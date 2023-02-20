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

struct sender : SenderType {
    var photoURL : String
    var senderId: String
    var displayName: String
}

class ChatDetailVC: MessagesViewController {

    
    @IBOutlet weak var msgCollectionView: MessagesCollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
}
