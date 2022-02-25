//
//  PersistenceManager.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 11/3/21.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping(GFErrors?) -> Void) {
        retrieveFavorites { result  in
            switch result {
            case .success(let favorites):
                var retrieveFavorite = favorites
                
                switch actionType {
                case .add:
                    guard !retrieveFavorite.contains(favorite) else {
                        completion(.alreadyInFavorite)
                        return
                    }
                    retrieveFavorite.append(favorite )
                case .remove:
                    retrieveFavorite.removeAll { $0.login == favorite.login  }
                }
                
                completion(save(favorite: retrieveFavorite))
                
            case .failure(let err):
                completion(err)
            }
        }
        
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFErrors>) -> Void) {
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let favorites = try JSONDecoder().decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorite: [Follower]) -> GFErrors? {
        do {
            let encoder = JSONEncoder()
            let encodeFovarite = try encoder.encode(favorite)
            defaults.set(encodeFovarite, forKey: keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
