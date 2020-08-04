//
//  ActivityIndicator.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation
import UIKit

// Used for ViewControllers that need to present an activity indicator when loading data.
public protocol ActivityIndicatorPresenter {

    var activityIndicator: UIActivityIndicatorView { get }

    func showLoader()

    func hideLoader()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {

    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            if #available(iOS 13.0, *) {
                welf.activityIndicator.style = UIActivityIndicatorView.Style.large
            } else {
                welf.activityIndicator.style = .gray
            }
            welf.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            welf.activityIndicator.center = CGPoint(x: UIScreen.main.bounds.maxX/2, y: UIScreen.main.bounds.maxY/2)
            welf.view.addSubview(welf.activityIndicator)
            welf.activityIndicator.layer.zPosition = 1000
            welf.activityIndicator.startAnimating()
        }
    }

    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            welf.activityIndicator.stopAnimating()
            welf.activityIndicator.removeFromSuperview()
        }
    }
}
