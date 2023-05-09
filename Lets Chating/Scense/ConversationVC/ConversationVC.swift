//
//  HomeVC.swift
//  Lets Chating
//
//  Created by Mo0oN on 25/04/2023.
//

import UIKit
import FirebaseAuth


class ConversationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ChatTableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatTableList.delegate = self
        ChatTableList.dataSource = self
        ChatTableList.registerNib(cell: ChatCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}
   

//MARK::- table functions
extension ConversationVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ChatCell
        cell.userNameL.text = "Hello World"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatVC()
        vc.title = "Sender name"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}


