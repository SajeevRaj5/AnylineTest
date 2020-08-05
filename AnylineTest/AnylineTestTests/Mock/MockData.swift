//
//  MockData.swift
//  AnylineTestTests
//
//  Created by sajeev Raj on 05/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

@testable import AnylineTest
import Foundation

class MockData {
    static let users = MockUser.getMockUsers()
    static let user = MockUser.getMockUsers().first!
    static let profile = MockUser.getMockProfile()
}

class MockUser: User {
    static func getMockUsers() -> [User] {
        let jsonData = Data("""
        {
          "login" : "Test Name",
          "score" : 1,
          "avatar_url" : "https://www.googlr.com"
        }
""".utf8)

        let user = try! JSONDecoder().decode(User.self, from: jsonData)
        return [user,user,user]
    }
    
    static func getMockProfile() -> Profile {
        let jsonData = Data("""
            {
            "login": "Test Name",
            "name": "Test Full Name",
            "avatar_url": "https://www.googlr.com",
            "followers": 1,
            "following": 2,
            "location": "4",
            "html_url": "https://www.googlr.com"
            }
""".utf8)
        let profile = try! JSONDecoder().decode(Profile.self, from: jsonData)
        return profile
    }
}
