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
    
    var users = [User]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadList()
            }
        }
    }

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Users"
    }

    // search users with text.
    func getUsers(text: String, completion:  (([User]?) -> Void)?) {
        showLoader()
        User.search(text: text, page: pageIndex) { [weak self] (response) in
            switch response {
            case .success(let data): completion?(data.items)
            case .failure(let error):
                AlertController.show(type: .serviceError, error: error)
                completion?(nil)
            case .finally: self?.hideLoader()
            }
        }
    }
    
    func search(text: String) {
        getUsers(text: text) { [weak self] newUserList in
            guard let newUserList = newUserList else { return }
            self?.users += newUserList
            if self?.users.isEmpty ?? true {
                AlertController.show(type: .empty)
            }
        }
    }
    
    func reloadList() {
        usersTableView?.reloadData()
        usersTableView?.animateCells(direction: .bottom)
    }
    
    func resetList() {
        users.removeAll()
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
            search(text: searchText)
        }
        
        return userCell
    }
    
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: UserInformationViewController.identifier) as? UserInformationViewController else { return }
        detailsView.configureView(user: users[indexPath.row])
        present(detailsView, animated: true, completion: nil)
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.searchTextField.text ?? ""
        resetList()
        search(text: searchText)
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
