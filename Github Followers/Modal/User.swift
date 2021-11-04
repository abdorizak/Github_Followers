//
//  User.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/27/21.
//

import Foundation

struct User: Codable {
    let login: String
    let avatar_url: String
    let name: String?
    let location: String?
    let bio: String?
    let public_repos: Int
    let public_gists: Int
    let html_url: String
    let followers: Int
    let following: Int
    let created_at: Date
}
