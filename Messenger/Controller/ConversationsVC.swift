//
//  ViewController.swift
//  Messenger
//
//  Created by Aniket Rao on 12/02/23.
//

import UIKit
import FirebaseAuth

class ConversationsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.validateUser()
    }
    
    private func validateUser(){
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let navigationController = UINavigationController(rootViewController: nextViewController)
//            UIApplication.shared.windows.first?.rootViewController = navigationController
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
        
    }

}

