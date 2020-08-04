//
//  Profile.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation

class Profile: Codable {
    var username: String
    var name: String
    var imageUrl: URL?
    var profileUrl: URL?
    var followers: Int
    var followings: Int
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        name = try container.decode(String.self, forKey: .name)
        let imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.imageUrl = URL(string: imageUrl)
        let profileUrl = try container.decode(String.self, forKey: .profileUrl)
        self.profileUrl = URL(string: profileUrl)
        followers = try container.decode(Int.self, forKey: .followers)
        followings = try container.decode(Int.self, forKey: .followings)
        location = try container.decode(String.self, forKey: .location)
    }
    
    static func getDetails(username: String, completion: @escaping (ServiceResponse<Profile>) -> ()) {
        Router.details(username: username).request { (response) in
            completion(response)
        }
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
