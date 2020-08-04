//
//  SearchUserViewController.swift
//  AnylineTest
//
//  Created by sajeev Raj on 04/08/2020.
//  Copyright © 2020 AnylineTest. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController, ActivityIndicatorPresenter {
    var activityIndicator = UIActivityIndicatorView()
    
    var pageIndex = 1
    var searchText = ""
    
    var users = [User]()

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Users"
    }

    // search users with text
    func getUsers(text: String, index: Int = 1) {
        showLoader()
        User.search(text: text, page: pageIndex) { [weak self] (response) in
            switch response {
            case .success(let data):
                self?.users += data.items
                DispatchQueue.main.async {
                    self?.reloadList()
                }
            case .failure(let error):
                print(error)
            case .finally:
                self?.hideLoader()
            }
        }
    }
    
    func reloadList() {
        usersTableView.reloadData()
        usersTableView.animateCells(direction: .bottom)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = UserViewCell.dequeue(tableView, at: indexPath) else { return UITableViewCell() }
        userCell.user = users[indexPath.row]
        
        if indexPath.row == users.count - 2 {
            pageIndex += 1
            getUsers(text: searchText, index: pageIndex)
        }
        
        return userCell
    }
    
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UserDetailViewController.identifier) as? UserDetailViewController else { return }
        detailsView.username = users[indexPath.row].username
        present(detailsView, animated: true, completion: nil)
    }

}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.searchTextField.text ?? ""

        getUsers(text: searchText)
        searchBar.searchTextField.resignFirstResponder()
    }
}
