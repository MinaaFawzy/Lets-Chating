//
//  HomePage.swift
//  Lets Chating
//
//  Created by Mo0oN on 01/05/2023.
//

import UIKit

class HomePage: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setVcToTapBar()
        setTabBarLayout()
    }
    
    func setVcToTapBar() {
        let ConversationVC = ConversationVC()
        let FriendVC = FriendsVC()
        let ProfileVC = ProfileVC()
        setTitleAndImage(name: "Conversation", VC: ConversationVC)
        setTitleAndImage(name: "Friends", VC: FriendVC)
        setTitleAndImage(name: "person", VC: ProfileVC)
        self.setViewControllers([ConversationVC,FriendVC,ProfileVC], animated: false)
    }

    func setTitleAndImage(name:String , VC: UIViewController) {
        let image = UIImage(named: name) == nil ? UIImage(systemName: name) : UIImage(named: name)
        VC.title = name
        VC.tabBarItem.image = image
        
    }

    func setTabBarLayout() {
            self.tabBar.layer.borderColor = UIColor.init(named: "grayBorder")?.cgColor
            self.tabBar.layer.borderWidth = 0.3
            self.tabBar.tintColor = .systemCyan
      
    }
}
