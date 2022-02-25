//
//  NetworkManager.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/27/21.
//

import Foundation
import UIKit

class NetworkManger {
    static let shared = NetworkManger()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
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
    
    
    func getUserInfo(for username: String, completion: @escaping(Result<User, GFErrors>) -> Void) {
        let endPoint = baseURL + "\(username)"
        
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
                decoder.dateDecodingStrategy  = .iso8601
                let userInfo = try decoder.decode(User.self, from: data)
                completion(.success(userInfo))
            } catch {
                completion(.failure(.inVlaidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data,
                  let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }
    
}
