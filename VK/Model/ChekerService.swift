//
//  ChekerService.swift
//  VK
//
//  Created by Andrei on 18.07.2023.


import Foundation
import FirebaseAuth
import UIKit


protocol CheckerServiceProtocol{
    func checkCredentials(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void)
    func signUp(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol{
    
    func checkCredentials(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil{
                if authResult != nil{
                    //print("User UID:", result.user.uid)
                    let user = User(userName: "robertDowne".localized, password: password, avatar: UIImage(named: "robertDowne")!, login: email, status: "advanced".localized)
                    completionBlock(.success(user))
                }
            }
            else{
                completionBlock(.failure(error!))
            }
        }
    }
    
    func signUp(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil{
                if authResult != nil{
                    //print("User UID:", result.user.uid)
                    let user = User(userName: "robertDowne".localized, password: password, avatar: UIImage(named: "robertDowne")!, login: email, status: "beginner".localized)
                    completionBlock(.success(user))
                }
            }
            else{
                completionBlock(.failure(error!))
            }
        }
    }
}
