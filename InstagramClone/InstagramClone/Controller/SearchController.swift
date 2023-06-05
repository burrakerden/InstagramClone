//
//  SearchController.swift
//  InstagramClone
//
//  Created by Burak Erden on 7.04.2023.
//

import UIKit

let reuseIdentifierTable = "UserCell"
let reuseIdentifierCollection = "ProfileCell"

class SearchController: UIViewController {
    
    //MARK: - Properties
    
    private var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifierCollection)
        return cv
    }()
    
    private var users = [User]()
    private var filteredUsers = [User]()
    private var posts = [Post]()
    private let searchController = UISearchController()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        fetchUsers()
        fetchPosts()
        configureUI()
    }
    
    //MARK: - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func fetchPosts() {
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Helpers

    func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifierTable)
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.isHidden = true
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }

}

//MARK: - UITableViewDataSource, Delegate

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTable, for: indexPath) as! UserCell
        cell.viewModel = UserCellViewModel(user: filteredUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProfileController(user: filteredUsers[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

//MARK: - UICollectionViewDataSource, Delegate

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCollection, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK: - UISearchResultsUpdating

extension SearchController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
            filteredUsers = users.filter({ $0.username.hasPrefix(searchText) || $0.fullname.lowercased().hasPrefix(searchText) })
            tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
    }
}

//MARK: - UICollectionViewDelegateFlowLayout    (Sizing)

extension SearchController: UICollectionViewDelegateFlowLayout {

    // space between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // space between each row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }

}
