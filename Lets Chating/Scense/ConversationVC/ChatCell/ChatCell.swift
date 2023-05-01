//
//  ChatCell.swift
//  Lets Chating
//
//  Created by Mo0oN on 25/04/2023.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = 40
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        userImage.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
