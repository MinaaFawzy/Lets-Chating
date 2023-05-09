//
//  ProfileVC.swift
//  Lets Chating
//
//  Created by Mo0oN on 01/05/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import JGProgressHUD

class ProfileVC: UIViewController {

    let db = Firestore.firestore()
    private let spinner = JGProgressHUD(style: .dark)
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = 50
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        userImage.layer.borderWidth = 1
        
        getData()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userPictureSelected))
        userImage.addGestureRecognizer(gesture)
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        spinner.show(in: view)
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.setValue(nil, forKey: "token")
            UserDefaults.standard.setValue(nil, forKey: "email")
            UserDefaults.standard.setValue(nil, forKey: "profilePicture")
        } catch {
            self.basicAlert(title: "Error", message: "Filed to Logout", ButtonTitle: "Ok")
        }
        spinner.dismiss(animated: true)
        let VC = LoginVC()
        navigationController?.setViewControllers([VC], animated: true)
    }
    @objc func userPictureSelected() {
        changeProfilePictureAlert()
    }
    
    func getData() {
        spinner.show(in: view)
        getProfilePicture()
        db.collection("users").document("\(Auth.auth().currentUser!.uid)").getDocument { snapshot, error in
            guard let userInfo = snapshot?.data() else {
                return
        }
            self.userName.text = userInfo["userName"] as? String
            self.email.text = userInfo["email"] as? String
            self.phoneNum.text = userInfo["phoneNum"] as? String
        }
       
        
    }
    
    func getProfilePicture() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = User.safeEmail(email: email)
        let path = "/image/\(safeEmail)_profile_picture.png"
        StorageManager.shared.downloadProfilePicture(path: path) { [weak self ]result in
            switch result {
            case .success(let imageURL):
                self?.downloadProfileImage(myImage: (self?.userImage)!, imageUrl: imageURL)
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    func downloadProfileImage(myImage: UIImageView, imageUrl: URL ) {
        URLSession.shared.dataTask(with: imageUrl, completionHandler:{ data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                myImage.image = image
                self.spinner.dismiss(animated: true)
            }
        }).resume()

    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func changeProfilePictureAlert() {
        let alert = UIAlertController(title: "Profile Picture",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Take a Photo",
                                      style: .default,
                                      handler: { [weak self] _ in
            self?.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Select a Photo",
                                      style: .default,
                                      handler: { [weak self] _ in
            self?.openPicturePicker()
        }))
        
        present(alert, animated: true)
        
    }
    func openCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate =  self
        present(vc, animated: true)
    }
    
    func openPicturePicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate =  self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        userImage.image = selectedImage
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
