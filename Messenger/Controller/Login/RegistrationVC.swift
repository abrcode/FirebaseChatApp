//
//  RegistrationVC.swift
//  Messenger
//
//  Created by Aniket Rao on 12/02/23.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var txtFieldFname: UITextField!
    @IBOutlet weak var txtFieldLName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPwd: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        self.initViews()
    }
    

}

// MARK: - SetupUI
extension RegistrationVC {

    func initViews(){
        
        self.showNavigationBar()
        
        //txtfields
        
        txtFieldPwd.layer.borderWidth = 1
        txtFieldEmail.layer.borderWidth = 1
        txtFieldFname.layer.borderWidth = 1
        txtFieldLName.layer.borderWidth = 1
        
        txtFieldPwd.layer.cornerRadius = 12
        txtFieldEmail.layer.cornerRadius = 12
        txtFieldFname.layer.cornerRadius = 12
        txtFieldLName.layer.cornerRadius = 12
        
        txtFieldPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtFieldEmail.layer.borderColor = UIColor.lightGray.cgColor
        txtFieldFname.layer.borderColor = UIColor.lightGray.cgColor
        txtFieldLName.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFieldPwd.layer.borderWidth = 1
        txtFieldEmail.layer.borderWidth = 1
        txtFieldFname.layer.borderWidth = 1
        txtFieldLName.layer.borderWidth = 1
        
        txtFieldPwd.layer.borderWidth = 1
        txtFieldEmail.layer.borderWidth = 1
        txtFieldFname.layer.borderWidth = 1
        txtFieldLName.layer.borderWidth = 1
        
        txtFieldFname.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        txtFieldLName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        txtFieldEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        txtFieldPwd.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        txtFieldFname.leftViewMode = .always
        txtFieldLName.leftViewMode = .always
        txtFieldEmail.leftViewMode = .always
        txtFieldPwd.leftViewMode = .always
        
        txtFieldPwd.isSecureTextEntry = true
        
        btnRegister.backgroundColor = .systemGreen
        btnRegister.layer.cornerRadius = 12
        btnRegister.setTitle("Register", for: .normal)
    }
    
}

// MARK: - Helper Methods
extension RegistrationVC {
    
    func showNavigationBar(){
       title = "Register"
    }

}


// MARK: - Action methods
extension RegistrationVC {
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
        
    }
    
}

// MARK: - UITextfieldDelegate
extension RegistrationVC  : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}

