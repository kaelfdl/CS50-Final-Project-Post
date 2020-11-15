//
//  LoginManager.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/25/20.
//

import Foundation

// Login Response Model
// Model is referenced from REST API Service Response
struct LoginResponse: Codable {
    let success: Bool?
    let message: String?
    let token: Token?
}

// Logout Response Model
struct LogoutResponse {
    let success: Bool?
    let message: String?
}

struct Test: Codable {
    let message: String?
}


// Login singleton for managing user login actions
class LoginManager {
    
    static let shared = LoginManager()
    
    private init() {}


    // User Login Handler
    // Returns a token if the user login is successfull
    func login(forURLString url: String, forParams params: [String : String]?, forBody body: [String : Any]?, forHTTPMethod httpMethod: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        guard let body = body else {return}
        
        let url = url
        let httpMethod = httpMethod
        let email = body["email"]
        let dataType = LoginResponse.self
        
        
        
        // Send login form
        NetworkManager.shared.requestDataFeed(forURLString: url, forHeaders: nil,forParams: nil, forBody: body,forHTTPMethod: httpMethod, forDataType: dataType, completion: { (result) in
            
            switch result {
            
            case.success(let data):
                print(data)
                // Assign issued token
                let token = data.token?.token
                
                // Login failed
                if (token == nil || data.success == false || email == nil) {
                    
                    completion(Result.success(data))
                    return
                }
                
                do {
                    // Register token
                    try AuthManager.shared.updateAuthCredentials(forEmail: email as! String, forToken: token!)
                    
                    if (data.success == true) {
                        completion(Result.success(data))
                    }
                    
                } catch (let error) {
                    print(error)
                }
                
                do {
                    // Register token
                    try AuthManager.shared.registerAuthCredentials(forEmail: email as! String, forToken: token!)
                    
                    if (data.success == true) {
                        completion(Result.success(data))
                    }
                    
                } catch (let error) {
                    print(error)
                }
                
                
            case.failure(let error):
                completion(Result.failure(error))
            }
            
        })
    }
    
    // User Signup Handler
    // Returns a token if the user signup is successfull
    func signup(forURLString url: String, forParams params: [String : String]?, forBody body: [String : Any]?, forHTTPMethod httpMethod: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        guard let body = body else {return}
        
        let url = url
        let httpMethod = httpMethod
        let email = body["email"]
        let dataType = LoginResponse.self
        
        
        
        // Send registration form
        NetworkManager.shared.requestDataFeed(forURLString: url, forHeaders: nil,forParams: nil, forBody: body,forHTTPMethod: httpMethod, forDataType: dataType, completion: { (result) in
            
            switch result {
            
            case.success(let data):
                
                // Assign issued token
                let token = data.token?.token
                
                // Registration failed
                if (token == nil || data.success! == false || email == nil) {
                    
                    completion(Result.success(data))
                    return
                }
                
                do {
                    // Register token
                    try AuthManager.shared.updateAuthCredentials(forEmail: email as! String, forToken: token!)
                    
                    if (data.success == true) {
                        completion(Result.success(data))
                    }
                    
                } catch (let error) {
                    print(error)
                }
                
                do {
                    // Register token
                    try AuthManager.shared.registerAuthCredentials(forEmail: email as! String, forToken: token!)
                    
                    if (data.success == true) {
                        completion(Result.success(data))
                    }
                    
                } catch (let error) {
                    print(error)
                }
                
                
            case.failure(let error):
                completion(Result.failure(error))
            }
            
        })
    }
    
    // Check User Auth
    func authenticateUser(withCredentials credentials: Credentials, forURLString url: String, forHTTPMethod httpMethod: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let url = url
        let httpMethod = httpMethod
        
        let dataType = LoginResponse.self
        
        let headers = ["Authorization": credentials.token]
        
        NetworkManager.shared.requestDataFeed(forURLString: url, forHeaders: headers, forParams: nil, forBody: nil, forHTTPMethod: httpMethod, forDataType: dataType, completion: {(result) in
            
            switch result {
            
            case.success(let data):
            
                
                if (data.success!) {
                    completion(Result.success(data.success!))
                } else {
                    completion(Result.success(data.success!))
                }
                    
            case.failure(let error):
                completion(Result.failure(error))
            }
            
        })
        
    }
    
    // User Logout Handler
    func logout() {
        
        do {
            try AuthManager.shared.deleteAuthCredentials()
            
            
        } catch (let error) {
            print(error)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
