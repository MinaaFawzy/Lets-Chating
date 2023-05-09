//
//  ChatVC.swift
//  Lets Chating
//
//  Created by Mo0oN on 09/05/2023.
//

import UIKit
import MessageKit


struct message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

struct Sender: SenderType {
    var photo: String
    var senderId: String
    var displayName: String
    
    
}
class ChatVC: MessagesViewController {

    private var messages = [message]()
    private let selfSender = Sender(photo: "",
                                senderId: "1",
                                displayName: "Mina Fawzy")
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        messages.append(message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("Hello")))
        messages.append(message(sender: selfSender,
                                messageId: "2",
                                sentDate: Date(),
                                kind: .text("Hello minaa")))
        messagesCollectionView.reloadData()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
}

extension ChatVC: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var currentSender: SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
