//
//  User.swift
//  VK
//
//  Created by Andrei on 15.07.2023.
//

import UIKit

protocol UserService{
    func entryLogin (login: String, password: String) -> User?
}

class User {
    
    let userName: String
    let password: String
    let avatar: UIImage
    let login: String
    let status: String
    
    init(userName: String, password: String, avatar: UIImage, login: String, status: String){
        self.userName = userName
        self.password = password
        self.avatar = avatar
        self.login = login
        self.status = status
    }

}
