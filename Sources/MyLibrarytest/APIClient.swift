//
//  APIClient.swift
//  
//
//  Created by yusen wang on 4/20/23.
//

import Foundation

public class APIClient {
    let baseURL = "https://jsonplaceholder.typicode.com"
    
    public func fetchData(_ completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let urlString = "\(baseURL)/todos/1" // This is the endpoint we'll be making a request to
        guard let url = URL(string: urlString) else {
        print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    guard let data = data else {
                        print("No data received")
                        return
                    }

                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            completion(.success(json))
                        } else {
                            print("Unable to parse JSON")
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
        task.resume()
    }
    
}
