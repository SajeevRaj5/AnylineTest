//
//  SearchUserViewControllerTests.swift
//  AnylineTestTests
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Quick
import Nimble
@testable import AnylineTest

class SearchUserViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: SearchUserViewController?

        beforeEach() {
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            viewController = storyboard.instantiateViewController(withIdentifier: SearchUserViewController.identifier) as? SearchUserViewController
            let mockNavigationController = MockNavigationController(rootViewController: viewController!)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = mockNavigationController
            window.makeKeyAndVisible()
            _  = viewController?.view
        }
        
        describe("Check if loaded") {
            
            it("Should load view") {
                _ = viewController?.view
                expect(viewController?.title).to(equal("Search Users"))
            }
        }
        
        describe("Search Users") {
            it("Should users") {
                viewController?.users.removeAll()
                viewController?.search(text: "Sajeev")
                expect(viewController?.users.count).toEventuallyNot(equal(0), timeout: 60, pollInterval: 5, description: "Should get users")
            }
        }
    
        describe("Populate User list") {
            it("Should display users") {
                viewController?.users = MockData.users
                expect(viewController?.usersTableView?.numberOfRows(inSection: 0)).toEventually(beGreaterThanOrEqualTo(viewController?.users.count), timeout: 3)
            }
        }
        
        describe("Populate User data") {
            it("Check user detail") {
                viewController?.users = MockData.users
                expect(viewController?.usersTableView.cellForRow(at: IndexPath(row: 0, section: 0)))
                    .toEventually(beAKindOf(UserViewCell.self), timeout: 5)
                expect((viewController?.usersTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UserViewCell)?.user?.username)
                    .toEventually(equal(viewController?.users[0].username), timeout: 3)

            }
        }
        
        describe("Did Select a user") {
            it("display details") {
                viewController?.users = MockData.users
                viewController?.tableView(viewController!.usersTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                expect(viewController?.presentedViewController)
                    .toEventually(beAKindOf(UserInformationViewController.self), timeout: 5)
            }
        }
    }
}

