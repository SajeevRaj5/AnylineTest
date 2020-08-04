//
//  View.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class View: UIView {

   @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
         didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
         }
     }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
         didSet {
             layer.borderWidth = borderWidth
         }
     }

}

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius

      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func animateAllSubViews(direction: AnimationDirection, duration: CGFloat = 1.5, delay: CGFloat = 0.05) {
        var delayCount: CGFloat = 0.0
        
        subviews.forEach { (eachView) in
            eachView.animate(direction: direction, duration:duration, delay: CGFloat(delayCount * delay))
            delayCount += 2
        }
    }
    
    func animate(direction: AnimationDirection, duration: CGFloat = 1.5, delay: CGFloat = 0.05) {
        transform = direction.transform()
        
        UIView.animate(withDuration: 1.25, delay: 0.05, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    enum AnimationDirection {
        case bottom
        case top
        case left
        case right
        
        func transform() -> CGAffineTransform {
            switch self {
            case .bottom: return CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            case .top:    return CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
            case .left:   return CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            case .right:  return CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            }
        }
    }
}
