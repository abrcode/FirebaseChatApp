//
//  ProfileVC.swift
//  Messenger
//
//  Created by Aniket Rao on 19/02/23.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    
    var data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTbl()
        // Do any additional setup after loading the view.
    }
    
    
    
}

// MARK: - Helper methods
extension ProfileVC {
    
    func setUpTbl(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
}

// MARK: - UITableView delegate and Datasource
extension ProfileVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let alertController = UIAlertController(title: "You want to log out from the app....?", message: "", preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: "Log Out", style: .destructive) { logout in
          
            do {
                try FirebaseAuth.Auth.auth().signOut()
            
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let navigationController = UINavigationController(rootViewController: nextViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: false)
                
            } catch  {
                print("Failed to log out..!")
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(firstAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

