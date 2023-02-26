//
//  ViewController.swift
//  Messenger
//
//  Created by Aniket Rao on 12/02/23.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblNoConversation: UILabel!
    
    
    //Variables
    
    private let spinner = JGProgressHUD(style: .dark)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
        self.setUpTable()
        self.initview()
        self.fetchConversation()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.validateUser()
    }
    
    @objc private func didTapComposeButton(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newConvVC = storyBoard.instantiateViewController(withIdentifier: "NewConversationVC") as! NewConversationVC
        let navigationController = UINavigationController(rootViewController: newConvVC)
        present(navigationController, animated: true)
    }

}


// MARK: - Helper Methods
extension ConversationsVC {
    
    func initview(){
        self.tableView.isHidden = true
        self.lblNoConversation.isHidden =  true
    }

    func setUpTable(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self    
    }
    
    func fetchConversation(){
        self.tableView.isHidden = false
    }
    
    
    
    private func validateUser(){
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let navigationController = UINavigationController(rootViewController: nextViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false)
            
            //            UIApplication.shared.windows.first?.rootViewController = navigationController
            //            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    
}


extension ConversationsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.selectionStyle = .none
        
        cell.textLabel?.text = "Hello World...!"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let chatDetailVC = storyBoard.instantiateViewController(withIdentifier: "ChatDetailVC") as! ChatDetailVC
        chatDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(chatDetailVC, animated: true)
        
    }
}
