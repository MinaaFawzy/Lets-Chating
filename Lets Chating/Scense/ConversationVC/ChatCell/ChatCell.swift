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
    func setData(userInfo: User) {
        userNameL.text = userInfo.userName
        getProfilePicture(email: userInfo.email )
    }
    func getProfilePicture(email:String) {
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
            }
        }).resume()

    }
    
    
}
