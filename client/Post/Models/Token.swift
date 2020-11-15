//
//  Token.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 11/4/20.
//

import Foundation

class Token: Codable {
    
    var token: String?
    var expiresIn: String?
    
    static let shared = Token()

    private init() {}
    
}
