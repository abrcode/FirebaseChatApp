//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Aniket Rao on 18/02/23.
//

import Foundation
import FirebaseDatabase


final class DatabaseManager {
    
    //Singleton
    static let shared = DatabaseManager()
    
    
    //For reference
    private let database = Database.database().reference()
    
//    func test(){
//
//        database.child("User").setValue(["name" : "Aniket" , "Something" : true])
//
//    }

}

// MARK: - Database Management
extension DatabaseManager{

    public func userExists(with email : String ,
                           completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapShot in
            
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
    }
    
    /// Inserts new user into database
    public func insertUser(with user: ChatAppUser){
        database.child(user.safeEmail ?? "").setValue([
            "first_Name" : user.firstName ?? "",
            "last_Name" : user.lastName ?? ""
        ])
    }
    
    
}

struct ChatAppUser {
    
    let firstName: String?
    let lastName: String?
    let emailAddress: String?
//    let profilePicture: String?
    
    var safeEmail: String? {
        var safeEmail = emailAddress?.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail?.replacingOccurrences(of: "@", with: "-")
        return safeEmail ?? ""
    }
    
}
