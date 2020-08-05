//
//  UserInformationViewControllerTests.swift
//  AnylineTestTests
//
//  Created by sajeev Raj on 05/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Quick
import Nimble
@testable import AnylineTest

class UserInformationViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: UserInformationViewController?
        let profile = MockData.profile

        beforeEach() {
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            viewController = storyboard.instantiateViewController(withIdentifier: UserInformationViewController.identifier) as? UserInformationViewController
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            _  = viewController?.view
        }
        

        describe("Details") {
            it("Should populate data") {
                viewController?.profile = profile
                viewController?.updateView()
                expect(viewController?.locationLabel?.text).to(equal(profile.location))
                expect(viewController?.nameLabel?.text).to(equal(profile.name))
                expect(viewController?.followersCountLabel?.text).to(equal(profile.followers.description))
                expect(viewController?.followingsCountLabel?.text).to(equal(profile.followings.description))
            }
        }
        
        describe("Get Details") {
                   it("Should fetch data") {
                    viewController?.getProfileDetails(username: "Sajeev")
//                    expect(viewController?.profile?.username).toEventuallyNot(beNil(),timeout: 60,pollInterval: 5)
            }
        }
    }
}
