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
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], GFErrors>) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.inValidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completion(.failure(.unableTopComplete))
                return
            }

            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.inValidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.inVlaidData))
                return
            }

            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let follwers = try decoder.decode([Follower].self, from: data)
                completion(.success(follwers))
            } catch {
                completion(.failure(.inVlaidData))
            }
        }
        
        task.resume()
        
        
    }
    
}