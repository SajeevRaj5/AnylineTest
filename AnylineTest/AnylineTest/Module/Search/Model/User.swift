//
//  User.swift
//  AnylineTest
//
//  Created by sajeev Raj on 03/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation

class User: Codable {
    var username: String
    var score: Int
    var imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case score = "score"
        case imageUrl = "avatar_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        score = try container.decode(Int.self, forKey: .score)
        let imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.imageUrl = URL(string: imageUrl)
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
