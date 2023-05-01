//
//  CustomView.swift
//  Lets Chating
//
//  Created by Mo0oN on 25/04/2023.
//

import Foundation
import UIKit

@IBDesignable
class CustomView: UIView {
    
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{self.layer.borderWidth = borderWidth}
    }
    @IBInspectable var borderColor:UIColor = UIColor.clear {
        didSet{self.layer.borderColor = borderColor.cgColor}
    }
    @IBInspectable var shadowColor:UIColor = UIColor.clear {
        didSet{self.layer.borderColor = shadowColor.cgColor}
    }
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{self.layer.cornerRadius = cornerRadius}
    }
    @IBInspectable var shadowRadius:CGFloat = 0 {
        didSet{self.layer.shadowRadius = cornerRadius}
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
}
