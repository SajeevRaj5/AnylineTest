//
//  Profile.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var username: String
    var name: String
    var imageUrl: URL
    var profileUrl: URL
    var followers: String
    var followings: String
    var location: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case name = "name"
        case imageUrl = "avatar_url"
        case followers = "followers"
        case followings = "following"
        case location = "location"
        case profileUrl = "html_url"
    }
}

extension Profile {
    enum Router: Requestable {
        case details(username: String)

        var path: String {
            switch self {
            case .details(let username):
                return "users/\(username)"
            }
        }
        
        var queryParameters: [String : String] {
            return [:]
        }
        
        var method: HTTPMethod {
            .get
        }
    }
}
