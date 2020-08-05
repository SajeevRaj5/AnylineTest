//
//  UserDetailViewControllerTests.swift
//  AnylineTestTests
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Quick
import Nimble
@testable import AnylineTest

class UserDetailViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: UserDetailViewController?

        beforeEach() {
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            viewController = storyboard.instantiateViewController(withIdentifier: UserDetailViewController.identifier) as? UserDetailViewController
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            _  = viewController?.view
        }
        
        describe("Check if loaded") {
            
            it("Should load view") {
                _ = viewController?.view
                expect(viewController?.title).to(equal("Search Users"))
            }
        }
    }
}
