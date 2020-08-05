//
//  AlertController.swift
//  AnylineTest
//
//  Created by sajeev Raj on 05/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation
import UIKit

typealias VoidClosure = () -> ()

class AlertController {
    enum Alert {
        case serviceError
        case empty
        
        var title: String {
            switch self {
            case .serviceError: return "Service unavailable"
            case .empty: return "No data found"
            }
        }
        
        var message: String {
            switch self {
            case .serviceError: return "Something went wrong. Please try again later"
            case .empty: return "No items found for the searched text"
            }
        }
    }
    
    static func show(type: Alert, error: Error? = nil, successHandler: VoidClosure? = nil, cancelHandler: VoidClosure? = nil) {
        let alertController = UIAlertController(title: type.title, message: error?.localizedDescription ?? type.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            successHandler?()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            topMostViewController().present(alertController, animated: true, completion: nil)
        }
    }
    
    class func topMostViewController() -> UIViewController {
        var topViewController: UIViewController? = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }
}
