import UIKit
import FirebaseAuth


class LoginVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!

   
    
   override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        passTF.delegate = self
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func CreateAccountButtonPressed(_ sender: Any) {
        let VC = CreateAccVC()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        if emailTF.text != "" && passTF.text != "" {
                login(email: emailTF.text!, pass: passTF.text!)
        } else {
            basicAlert(title: "Error", message: "Please Enter e-mail or password ", ButtonTitle: "Ok")
        }
    }
    
    
    func login(email: String, pass: String) {
        Auth.auth().signIn(withEmail: email, password: pass){ authResult, error in
            if authResult != nil {
                let token = authResult!.user.uid
                UserDefaults.standard.setValue(token, forKey: "token")
                Auth.auth().addStateDidChangeListener { result, user in
                    let vc = HomePage()
                    self.navigationController?.setViewControllers([vc], animated: true)
                }
            } else {
                self.basicAlert(title: "Login Filed", message: error?.localizedDescription, ButtonTitle: "Ok")
            }
            
        }
    }
}



extension LoginVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            passTF.becomeFirstResponder()
        } else if textField == passTF {
            if emailTF.text != "" && passTF.text != "" {
                    login(email: emailTF.text!, pass: passTF.text!)
            } else {
                basicAlert(title: "Error", message: "Please Enter e-mail or password ", ButtonTitle: "Ok")
            }
        }
        return true
    }
    
}

