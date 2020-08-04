//
//  TableViewExtension.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

extension UITableView {
    
    func animateCells(direction: Direction, duration: Double = 1.0, delay: Double = 0.05) {
        
        func getYPosition(tableView: UITableView, direction: Direction) -> CGFloat {
            return direction == .top ? 0 : tableView.bounds.size.height
        }
        
        reloadData()
        let tableHeight = getYPosition(tableView: self, direction: direction)
        
        for cell in visibleCells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var delayCount = 0
        for cell in visibleCells {
            UIView.animate(withDuration: duration, delay: Double(delayCount) * delay, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCount += 1
        }
    }
    
    enum Direction {
        case top
        case bottom
    }
}
