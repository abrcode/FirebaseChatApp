//
//  LoginVC.swift
//  Messenger
//
//  Created by Aniket Rao on 12/02/23.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPwd: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initViews()
        
    }

  
}

// MARK: - Custom UI

extension LoginVC{

    func initViews(){
        
        self.showNavigationBar()
        
        //txtfields
        txtFieldEmail.layer.cornerRadius = 12
        txtFieldPwd.layer.cornerRadius = 12
        btnLogin.layer.cornerRadius = 12
        
        
        txtFieldEmail.layer.borderWidth = 1
        txtFieldPwd.layer.borderWidth = 1
        
        txtFieldEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        txtFieldPwd.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        txtFieldEmail.leftViewMode = .always
        txtFieldPwd.leftViewMode = .always
        
        txtFieldEmail.layer.borderColor = UIColor.lightGray.cgColor
        txtFieldPwd.layer.borderColor = UIColor.lightGray.cgColor
        btnLogin.backgroundColor = .link
        btnLogin.setTitle("Log In", for: .normal)
        
        txtFieldPwd.isSecureTextEntry = true
        
    }
    
}


// MARK: - Helper Methods
extension LoginVC {
    
    func showNavigationBar(){
        title = "Log In"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
    }
    
    
    func alertLoginError(){
        let alertController = UIAlertController(title: "Whoops...!", message: "Please enter all information to Log in.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
    func loginTapped(){
        
        txtFieldEmail.becomeFirstResponder()
        txtFieldPwd.becomeFirstResponder()
        
        guard let email = txtFieldEmail.text , let pwd = txtFieldPwd.text , !email.isEmpty , !pwd.isEmpty , pwd.count >= 6 else {
            self.alertLoginError()
            return
        }
        
        
    }

}


// MARK: - Action Methods
extension LoginVC {
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.loginTapped()
    }
    
    @objc private func didTapRegister(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let registrationVC = storyBoard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
}


// MARK: - TextfieldDlegate

extension LoginVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          
        switch textField {
        case txtFieldEmail:
            
            txtFieldPwd.becomeFirstResponder()
            
        case txtFieldPwd:
            
            self.loginTapped()
            
        default:
            break
        }
        
        return true
    }
    
}
