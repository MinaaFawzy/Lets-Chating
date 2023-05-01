import Foundation
import UIKit
@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{self.layer.borderWidth = borderWidth}
    }
    @IBInspectable var borderColor:UIColor = UIColor.clear {
        didSet{self.layer.borderColor = borderColor.cgColor}
    }
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{self.layer.cornerRadius = cornerRadius}
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
    }
    
}
