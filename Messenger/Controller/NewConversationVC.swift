//
//  NewConversationVC.swift
//  Messenger
//
//  Created by Aniket Rao on 12/02/23.
//

import UIKit
import JGProgressHUD

class NewConversationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoResult: UILabel!
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for users.."
        return searchBar
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        searchBar.becomeFirstResponder()
        setUpTable()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpTable(){
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    @objc func didTapCancel(){
        dismiss(animated: true, completion: nil )
    }
    
}

extension NewConversationVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         
    }
}

// MARK: - Delegate and Datsource of Tableview
extension NewConversationVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "User1!  "
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}
