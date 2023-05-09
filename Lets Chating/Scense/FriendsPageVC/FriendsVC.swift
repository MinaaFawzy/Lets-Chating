//
//  FriendsVC.swift
//  Lets Chating
//
//  Created by Mo0oN on 25/04/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import JGProgressHUD

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var friendsTable: UITableView!
   
    let spinner = JGProgressHUD(style: .dark)
    let db  = Firestore.firestore()
    var friends:[User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTable.delegate = self
        friendsTable.dataSource = self
        friendsTable.registerNib(cell: ChatCell.self)
        getFriends()

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden =  true
    }
    
    @IBAction func addFriendButtonPressed(_ sender: Any) {
        var phone = ""
        let alert = UIAlertController(title: "Add New Friend",
                                      message: "Enter the Number of your friend",
                                      preferredStyle: .alert)
        alert.addTextField(){ (phoneNum) in
            phoneNum.placeholder = "Enter your friend is Number"
        }
        let alertAction = UIAlertAction(title: "Add",
                                        style: .default) { [self] UIAlertAction in
            phone = alert.textFields![0].text!
            self.db.collection("users").whereField("phoneNum", isEqualTo: phone).getDocuments { [self] snapshot, error in
                if error != nil {
                    print(error!)
                } else {
                    if (snapshot?.documents.count)! > 0 {
                        self.db.collection("users").document("\(Auth.auth().currentUser!.uid)" ).collection("friends").document().setData(snapshot!.documents[0].data())
                        self.basicAlert(title: "Your friend added succssfuly", message: "", ButtonTitle: "Done")
                        let temp = snapshot!.documents[0].data()
                        let newFriend = User(id: temp["id"] as! String,
                                            userName: temp["userName"] as! String,
                                             email: temp["email"] as! String,
                                             phoneNum: temp["phoneNum"] as! String)
                        friends.append(newFriend)
                        friendsTable.reloadData()
                    }
                    
                }
            }
        }
        
        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    
    func getFriends() {
        spinner.show(in: view)
        db.collection("users").document("\(Auth.auth().currentUser!.uid)").collection("friends").getDocuments { [self] snapshot, error in
            if snapshot != nil {
                for friend in snapshot!.documents {
                    db.collection("users").document("\(Auth.auth().currentUser!.uid)").collection("friends").document(friend.documentID).getDocument { snapshot, error in
                        let temp = snapshot?.data()
                        let user = User(id: temp!["id"] as! String,
                                        userName: temp!["userName"] as! String,
                                        email: temp!["email"] as! String,
                                        phoneNum: temp!["phoneNum"] as! String)
                        
                        self.friends.append(user)
                        self.friendsTable.reloadData()
                    }
                }
            }
        }
        spinner.dismiss(animated: true)
    }
    
}

//MARK: - table Extension
extension FriendsVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ChatCell
        cell.setData(userInfo: friends[indexPath.row])
        return cell
        
    }
}
