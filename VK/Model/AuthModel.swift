//
//  AuthModel.swift
//  VK
//
//  Created by Andrei on 18.07.2023.
//
import Foundation
import RealmSwift

class AuthUser: Object{
    @Persisted var login: String
    @Persisted var password: String
    @Persisted (primaryKey: true) var id: ObjectId
}
