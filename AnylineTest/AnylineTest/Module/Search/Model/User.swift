//
//  User.swift
//  AnylineTest
//
//  Created by sajeev Raj on 03/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation

class User: Codable {
    var name: String
    var score: Int
    var imageUrl: URL?
    var reposUrl: URL?
    var followersUrl: URL?
    var subscriptionsUrl: URL?
    var organizationsUrl: URL?
    var eventsUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case score = "score"
        case imageUrl = "avatar_url"
        case followersUrl = "followers_url"
        case subscriptionsUrl = "subscriptions_url"
        case reposUrl = "repos_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        score = try container.decode(Int.self, forKey: .score)
        let imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.imageUrl = URL(string: imageUrl)
        
        let reposUrl = try container.decode(String.self, forKey: .reposUrl)
        self.reposUrl = URL(string: reposUrl)
        
        let followersUrl = try container.decode(String.self, forKey: .followersUrl)
        self.followersUrl = URL(string: followersUrl)
        
        let subscriptionsUrl = try container.decode(String.self, forKey: .subscriptionsUrl)
        self.subscriptionsUrl = URL(string: subscriptionsUrl)
    
    }
    
    static func search(text: String,page: Int, completion: @escaping (ServiceResponse<UserSearchResponse>) -> ()) {
        Router.search(text: text, page: page).request { (response: ServiceResponse<UserSearchResponse>) in
            completion(response)
        }
    }
}

extension User {
    enum Router: Requestable {
        case search(text: String, page: Int)
        
        var queryParameters: [String : String] {
            switch self {
            case .search(let text, let page):
                return [
                    "q": text,
                    "page": "\(page)",
                    "per_page": "50"
                ]
            }
        }
        
        var additionalHeaderParameters: [String : String] {
            return ["Content-Type": "application/x-www-form-urlencoded"]
        }
                
        var path: String {
            switch self {
            case .search: return "search/users"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .search: return .get
            }
        }
    }
}

class UserSearchResponse: Codable {
    var count = 0
    var items = [User]()

    enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case items = "items"
    }
}
