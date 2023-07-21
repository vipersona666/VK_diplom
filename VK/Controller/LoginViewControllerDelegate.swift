//
//  LoginViewControllerDelegate.swift
//  VK
//
//  Created by Andrei on 18.07.2023.
//

import Foundation

protocol LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool
}
