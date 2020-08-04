//
//  MockNavigationController.swift
//  AnylineTestTests
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
    
    func getNavigationController(for viewController: UIViewController) -> MockNavigationController {
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = navigationController
        return MockNavigationController(rootViewController: viewController)
    }
}
