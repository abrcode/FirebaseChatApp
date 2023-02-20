//
//  RegistrationVC.swift
//  Messenger
//
//  Created by Aniket Rao on 12/02/23.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegistrationVC: UIViewController {

    @IBOutlet weak var txtFieldFname: UITextField!
    @IBOutlet weak var txtFieldLName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPwd: UITextField!
    @IBOutlet weak var imgViewAvatar: UIImageView!
    
    @IBOutlet weak var btnRegister: UIButton!
    
        // Variables
    
    private let spinner = JGProgressHUD(style: .dark)
    
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
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatar))
        imgViewAvatar.addGestureRecognizer(gesture)
        imgViewAvatar.isUserInteractionEnabled = true
        
    }
    
}

// MARK: - Helper Methods
extension RegistrationVC {
    
    func showNavigationBar(){
       title = "Register"
    }

    func registrationError(){
        let alertController = UIAlertController(title: "Whoops...!", message: "Please enter all the information to create an account.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}


// MARK: - Action methods
extension RegistrationVC {
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
        self.registrationTapped()
    }
    
    @objc private func tapOnAvatar(){
        print("Avatar image tapped")
        self.presentPhotoActionSheet()
    }
    
    func registrationTapped(){
        
        txtFieldFname.becomeFirstResponder()
        txtFieldLName.becomeFirstResponder()
        txtFieldEmail.becomeFirstResponder()
        txtFieldPwd.becomeFirstResponder()
        
        guard let fname = txtFieldFname.text,
              let lname = txtFieldLName.text,
              let email = txtFieldEmail.text,
              let pwd = txtFieldPwd.text,
              !fname.isEmpty,
              !lname.isEmpty,
              !email.isEmpty,
              !pwd.isEmpty,
              pwd.count >= 6  else {
            
            self.registrationError()
            return
        }
        
        spinner.show(in: view)
        
        // complete process For Firebase Signup
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pwd) { [weak self] authResult , error in
            
            guard let strongSelf = self else {
                return
            }
             
            DispatchQueue.main.sync {
                strongSelf.spinner.dismiss()
            }
        
            guard let result = authResult, error == nil else {
                print("Error at the time of Creation :\(error?.localizedDescription)")
                return
            }
            
             let user = result.user
            print("Create User Data: \(user)")
            
            DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: fname,
                                                                lastName: lname,
                                                                emailAddress: email))
            
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - UITextfieldDelegate
extension RegistrationVC  : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case txtFieldFname:
            txtFieldLName.becomeFirstResponder()
        case txtFieldLName:
            txtFieldEmail.becomeFirstResponder()
        case txtFieldEmail:
            txtFieldPwd.becomeFirstResponder()
        case txtFieldPwd:
            self.registrationTapped()
        default:
            break
        }
        
        return true
    }
    
}

// MARK: - Imagepicker delegate
extension RegistrationVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let alertController = UIAlertController(title: "Profile picture" , message: "How would you like to select a picture", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
        alertController.addAction(UIAlertAction(title: "Take a photo", style: .default) { _ in
            self.presentCamera()
        })
        
        alertController.addAction(UIAlertAction(title: "Chose a photo", style: .default) { _ in
            self.presentPhotoPicker()
        })

        present(alertController, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        print("Image Info :\(info)")
        guard let selectImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.imgViewAvatar.image = selectImg
        self.imgViewAvatar.layer.cornerRadius = self.imgViewAvatar.frame.width / 2
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
