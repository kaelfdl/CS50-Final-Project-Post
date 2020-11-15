//
//  AuthManager.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/26/20.
//

import Foundation

struct Credentials {
    var email: String?
    var token: String?
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    // Check for User authentication
    func checkAuth() throws -> Credentials {
        let url = "http://localhost:3000"
        
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: url,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else {throw KeychainError.noPassword}
        guard status == errSecSuccess else {throw KeychainError.unhandledError(status: status)}
        
        guard let existingItem = item as? [String : Any],
              let tokenData = existingItem[kSecValueData as String] as? Data,
              let token = String(data: tokenData, encoding: String.Encoding.utf8),
              let account = existingItem[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        
        let credentials = Credentials(email: account, token: token)
        
        return credentials
    }
    
    // Register received authentication credentials from the server
    func registerAuthCredentials(forEmail email: String, forToken token: String) throws {
        
        let credentials = Credentials.init(email: email , token: token)
        
        let server = "http://localhost:3000"
        
        guard let account = credentials.email else {return}
        guard let token = credentials.token?.data(using: String.Encoding.utf8) else {return}
        
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: token]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    
    // Update User Authentication Credentials
    func updateAuthCredentials(forEmail email: String, forToken token: String) throws {
        
        let url = "http://localhost:3000"
        
        
        // Construct a search query
        let query: [String: Any] = [kSecClass as String : kSecClassInternetPassword,
                                    kSecAttrServer as String: url]
        
        // Newly defined User Credential data
        let credentials = Credentials(email: email, token: token)
        
        
        let account = credentials.email
        let tokenData = credentials.token?.data(using: String.Encoding.utf8)
        
        let attributes: [String: Any] = [kSecAttrAccount as String: account!,
                                         kSecValueData as String: tokenData!]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword}
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status)}
        
    }
    
    // Delete User Authentication Credentials
    func deleteAuthCredentials() throws {
        
        let url = "http://localhost:3000"
        
        let query: [String: Any] = [kSecClass as String : kSecClassInternetPassword,
                                    kSecAttrServer as String: url]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status)}
        
        
    }
}
