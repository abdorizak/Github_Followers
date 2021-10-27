//
//  NetworkManager.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/27/21.
//

import Foundation

class NetworkManger {
    static let shared = NetworkManger()
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping([Follower]?, ErrorMessage?) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(nil, .inValidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completion(nil, .unableTopComplete)
                return
            }

            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(nil, .inValidResponse)
                return
            }

            guard let data = data else {
                completion(nil, .inVlaidData)
                return
            }

            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follwers = try decoder.decode([Follower].self, from: data)
                completion(follwers, nil)
            } catch {
                completion(nil, .inVlaidData)
            }
        }
        
        task.resume()
        
        
    }
    
}
