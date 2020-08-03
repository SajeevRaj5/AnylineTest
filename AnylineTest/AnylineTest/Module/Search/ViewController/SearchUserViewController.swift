//
//  SearchUserViewController.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {
    
    var pageIndex = 1
    var users = [User]()

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func getUser(text: String) {
        User.search(text: text, page: pageIndex) { (response) in
            switch response {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            case .finally:
                print("finish")
            }
        }
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getUser(text: searchBar.searchTextField.text!)
    }
}
