//
//  User.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/24/20.
//

import Foundation

struct UserResponse: Codable {
    let success: Bool
    let user: User?
}

struct User: Codable {
    let id: String?
    let username: String
    let password: String?
    let email: String
    var first_name: String?
    var last_name: String?
}
