//
//  CreateAccVC.swift
//  Lets Chating
//
//  Created by Mo0oN on 25/04/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CreateAccVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: PasswordTF!
    @IBOutlet weak var confirmPassTF: PasswordTF!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    

    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTF.delegate = self
        emailTF.delegate = self
        passTF.delegate = self
        confirmPassTF.delegate = self
        phoneNumTF.delegate = self
        
        userImage.layer.cornerRadius = 50
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        userImage.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}

//MARK:- @OBACtions
extension CreateAccVC {
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func signUpButtonPressed(_ sender: Any) {
        if userNameTF.text != "" && emailTF.text != "" && passTF.text != "" && confirmPassTF.text != "" && phoneNumTF.text != "" {
            if passTF.text == confirmPassTF.text {
                signup(userName: userNameTF.text!, email: emailTF.text!, password: passTF.text!, phoneNum: phoneNumTF.text!)
            } else {
                basicAlert(title: "Error", message: "Password didn't match", ButtonTitle: "Ok")
            }
        } else {
            basicAlert(title: "Error", message: "Complete your information", ButtonTitle: "Ok")
        }
    }
}


//MARK:- extension Functions
extension CreateAccVC {
    @objc func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
    
    func signup(userName: String, email: String, password: String, phoneNum: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if authResult != nil {
                let newUser = User(id: (authResult?.user.uid)!, userName: userName, email: email, phoneNum: phoneNum)
                self.db.collection("users").document((authResult?.user.uid)!).setData(newUser.toAnyObject() as! [String : Any])
                self.navigationController?.pushViewController(LoginVC(), animated: true)
                self.basicAlert(title: "Creat Account Successfuly", message: nil, ButtonTitle: "Ok")
            } else {
                self.basicAlert(title: "Creat Account Filed", message: error?.localizedDescription, ButtonTitle: "Ok")
            }
            
        }
        
    }
}

//MARK:- UIText Filed Delegate
extension CreateAccVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            emailTF.becomeFirstResponder()
        } else if textField == emailTF{
            phoneNumTF.becomeFirstResponder()
        }else if textField == phoneNumTF{
            passTF.becomeFirstResponder()
        }else if textField == passTF{
            confirmPassTF.becomeFirstResponder()
        } else if textField == confirmPassTF {
            if userNameTF.text != "" && emailTF.text != "" && passTF.text != "" && confirmPassTF.text != "" && phoneNumTF.text != "" {
                if passTF.text == confirmPassTF.text {
                    signup(userName: userNameTF.text!, email: emailTF.text!, password: passTF.text!, phoneNum: phoneNumTF.text!)
                } else {
                    basicAlert(title: "Error", message: "Password didn't match", ButtonTitle: "Ok")
                }
            } else {
                basicAlert(title: "Error", message: "Complete your information", ButtonTitle: "Ok")
            }
        }
        return true
    }
    
}

//MARK:- Image picker controller
extension CreateAccVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet(){
        let alert = UIAlertController(title: "Profile Picture",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Take a photo",
                                      style: .default,
                                      handler: { [weak self ] _ in
            self?.presentCamera()
        }))
        alert.addAction(UIAlertAction(title: "Select a photo",
                                      style: .default,
                                      handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(alert, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
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

