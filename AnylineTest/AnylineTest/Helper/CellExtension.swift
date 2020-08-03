//
//  CellExtension.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class func dequeue(_ tableView: UITableView,at indexPath: IndexPath) -> Self? {
        return tableView.dequeueReusableCell(withIdentifier: Self.identifier, for: indexPath) as? Self
    }
}
