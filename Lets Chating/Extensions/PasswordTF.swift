import UIKit

class PasswordTF: UITextField {
    
    let eyeButton = UIButton(frame: CGRect(x: 0.0, y: 10.0, width: 15.0, height: 15.0))
    var showFlag = true
    
    override func draw(_ rect: CGRect) {
        eyeButton.setImage(UIImage(named: "visable"), for: .normal)
        self.rightView = eyeButton
        self.rightViewMode = .always
        self.isSecureTextEntry = true
        showFlag = false
        
        //eyeButton.contentEdgeInsets = .init(top: 3, left: 3, bottom: 3, right: 5)
        eyeButton.addTarget(self, action: #selector(changeButtinImage), for: .touchUpInside)
        
    }
    
    @objc func changeButtinImage() {
        if showFlag {
            eyeButton.setImage(UIImage(named: "visable"), for: .normal)
            self.rightView = eyeButton
            self.rightViewMode = .always
            self.isSecureTextEntry = true
            showFlag = false
        } else {
            eyeButton.setImage(UIImage(named: "invisable"), for: .normal)
            self.rightView = eyeButton
            self.rightViewMode = .always
            self.isSecureTextEntry = false
            showFlag = true
        }
    }
    
}
