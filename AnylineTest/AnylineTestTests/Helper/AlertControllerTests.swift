//
//  AlertControllerTests.swift
//  AnylineTestTests
//
//  Created by sajeev Raj on 05/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Quick
import Nimble
@testable import AnylineTest

class AlertControllerTests: QuickSpec {
    override func spec() {
        
        context("did show alert") {
            beforeEach {
                MockAlertController.show(type: .serviceError)
            }
            
            it("check to show alert") {
                print(MockAlertController.topMostViewController())
            }
        }
    }
    
    class MockAlertController : AlertController {
        override class func topMostViewController() -> UIViewController {
            let vc =  MockNavigationController().topViewController ?? UIViewController()
            _ = vc.view
            return vc
        }
    }
}

