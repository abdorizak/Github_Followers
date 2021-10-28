//
//  ErrorMessage.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/27/21.
//

import Foundation

enum GFErrors: String, Error {
     case inValidUsername = "this username created an invalid request. please try again.."
    case unableTopComplete = "Unable to complete you request. Please check your Internet connection.."
    case inValidResponse = "Invalid response from the server. please try again."
    case inVlaidData = "the data recevied from the server was Invalid. please try again."
}
