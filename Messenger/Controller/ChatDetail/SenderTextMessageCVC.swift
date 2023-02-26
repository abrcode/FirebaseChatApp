//
//  TextMessageCVC.swift
//  Messenger
//
//  Created by Aniket Rao on 26/02/23.
//

import UIKit
import MessageKit

class SenderTextMessageCVC: TextMessageCell {
    
    @IBOutlet weak var txtMessage: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setupSubviews() {
        super.setupSubviews()
        
        setUpView()
    }
    
    func setUpView(){
        
        txtMessage.numberOfLines = 0
        txtMessage.font = UIFont.systemFont(ofSize: 17)
        txtMessage.textColor = .red
        
    }
  
    
    
    override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else { return  }
        
        guard case let .text(text) = message.kind else { return  }
        
        txtMessage.text = text
    }
    
}
