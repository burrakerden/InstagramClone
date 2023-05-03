//
//  SearchController.swift
//  InstagramClone
//
//  Created by Burak Erden on 7.04.2023.
//

import UIKit

let reuseIdentifierTable = "UserCell"

class SearchController: UITableViewController {
    
    //MARK: - Properties

    private var users = [User]()
    private var filteredUsers = [User]()
    private let searchController = UISearchController()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        fetchUsers()
    }
    
    //MARK: - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers

    func configureTableView() {
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifierTable)
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }

}

//MARK: - UITableViewDataSource, Delegate

extension SearchController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTable, for: indexPath) as! UserCell
        cell.viewModel = UserCellViewModel(user: filteredUsers[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProfileController(user: filteredUsers[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

//MARK: - UISearchResultsUpdating

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        if searchText.count >= 1 {
            filteredUsers = users.filter({ $0.username.hasPrefix(searchText) || $0.fullname.lowercased().hasPrefix(searchText) })
            tableView.reloadData()
        } else {
            self.filteredUsers = users
            tableView.reloadData()
        }
    }
    
}

