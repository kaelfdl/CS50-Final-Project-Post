//
//  UserManager.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/31/20.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    //------ Active User Methods ------
    
    // Retrieve Active User Profile
    func retrieveActiveUserProfile(completionHandler: @escaping (Result<UserResponse, Error>) -> Void) {
        do {
            let url = "http://localhost:3000/users/me"
            
            let credentials = try AuthManager.shared.checkAuth()
            
            let headers = ["Authorization": credentials.token]
            let httpMethod = "GET"
            
            NetworkManager.shared.requestDataFeed(forURLString: url, forHeaders: headers, forParams: nil, forBody: nil, forHTTPMethod: httpMethod, forDataType: UserResponse.self, completion: {(result) in
                
                switch (result) {
                case.success(let response):
                    completionHandler(Result.success(response))
                case.failure(let error):
                    completionHandler(Result.failure(error))
                }
            })
            
        } catch (let error) {
            completionHandler(Result.failure(error))
        }
    }
    
    // Delete Active User Profile
    func deleteActiveUserProfile(completionHandler: @escaping (Result<UserResponse, Error>) -> Void) {
        do {
            let url = "http://localhost:3000/users/me"
            
            let credentials = try AuthManager.shared.checkAuth()
            
            let headers = ["Authorization": credentials.token]
            let httpMethod = "DELETE"
            
            NetworkManager.shared.requestDataFeed(forURLString: url, forHeaders: headers, forParams: nil, forBody: nil, forHTTPMethod: httpMethod, forDataType: UserResponse.self, completion: {(result) in
                
                switch (result) {
                case.success(let response):
                    completionHandler(Result.success(response))
                case.failure(let error):
                    completionHandler(Result.failure(error))
                }
            })

        } catch (let error) {
            completionHandler(Result.failure(error))
        }
    }
}
