//
//  ProfileVC.swift
//  Lets Chating
//
//  Created by Mo0oN on 01/05/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ProfileVC: UIViewController {

    let db = Firestore.firestore()
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = 50
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        userImage.layer.borderWidth = 1
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userPictureSelected))
        userImage.addGestureRecognizer(gesture)
    }
    override func viewWillLayoutSubviews() {
        db.collection("users").document("\(Auth.auth().currentUser!.uid)").getDocument { snapshot, error in
            guard let userInfo = snapshot?.data() else {
                return
        }
            self.userName.text = userInfo["userName"] as? String
            self.email.text = userInfo["email"] as? String
            self.phoneNum.text = userInfo["phoneNum"] as? String
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.setValue(nil, forKey: "token")
        } catch {
            self.basicAlert(title: "Error", message: "Filed to Logout", ButtonTitle: "Ok")
        }
        let VC = LoginVC()
        navigationController?.setViewControllers([VC], animated: true)
    }
    @objc func userPictureSelected() {
        changeProfilePictureAlert()
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
