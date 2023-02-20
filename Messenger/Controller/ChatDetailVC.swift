//
//  ChatDetailVC.swift
//  Messenger
//
//  Created by Aniket Rao on 20/02/23.
//

import UIKit
import MessageKit


// MARK: - Basic Messge fields

struct Message : MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

// MARK: - Sender fields

struct Sender : SenderType {
    var photoURL : String
    var senderId: String
    var displayName: String
}

class ChatDetailVC: MessagesViewController {

    
    @IBOutlet weak var msgCollectionView: MessagesCollectionView!
    
    
    private var messages = [Message]()
    private var selfSender = Sender(photoURL: "",
                                    senderId: "1",
                                    displayName: "Aniket Rao")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("Hello world message...!")))
        
        messages.append(Message(sender: selfSender,
                                messageId: "2",
                                sentDate: Date(),
                                kind: .text("Hello world message...! Hello world message...! Hello world message...! Hello world message...! Hello world message...! Hello world message...! Hello world message...! Hello world message...! Hello world message...!")))
        
        self.setUpMsgCollectionView()
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - Helper methods
extension ChatDetailVC {
    
    func setUpMsgCollectionView(){
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
    }
    
}

// MARK: - MessgeCllctionView Dlegate datasource
extension ChatDetailVC : MessagesLayoutDelegate, MessagesDataSource , MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
