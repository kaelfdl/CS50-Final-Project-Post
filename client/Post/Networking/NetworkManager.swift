//
//  NetworkManager.swift
//  Post
//
//  Created by Gabryel Flor de Lis on 10/24/20.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // Create a URL Session to send request and retrieve data
    // Function accepts T data type that should match expected data
    func requestDataFeed<T>(forURLString urlString: String, forHeaders headers: [String: String?]?, forParams params: [String: String]?, forBody body: [String: Any]?,forHTTPMethod httpMethod: String, forDataType dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        
        // Create a url component with the string provided
        var urlComp = URLComponents(string: urlString)
        
        var items = [URLQueryItem]()
        
        // Pass the parameters into the Url as a query item
        if let params = params {
            
            for (key, value) in params {
                items.append(URLQueryItem(name: key, value: value))
            }
            
            items = items.filter{!$0.name.isEmpty}
            
            if (!items.isEmpty) {
                urlComp?.queryItems = items
            }
        }
        
        // Build a request object using the url component created earlier
        var request = URLRequest(url: (urlComp?.url!)!)
        
        // Pass in a dictionary object and convert it into a json data object
        if let body = body {
            
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        // Request Method
        request.httpMethod = httpMethod
        
        // Request Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let headers = headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        // URL SESSION
        let session = URLSession(configuration: .default)
        
        // API Request
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let data = data else {return}
                
            do {
                
                if (error) != nil {
                    completion(Result.failure(error!))
                    return
                }
                
                let result = try JSONDecoder().decode(dataType, from: data)
                
                
                completion(Result.success(result))
                
            } catch let error {
                completion(Result.failure(error))
            }
            
        }).resume()
    }
}
