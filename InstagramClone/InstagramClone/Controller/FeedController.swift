//
//  FeedController.swift
//  InstagramClone
//
//  Created by Burak Erden on 7.04.2023.
//

import UIKit
import Firebase

class FeedController: UICollectionViewController {
    
    //MARK: - Properties
    
    let reuseIdentifier = "cell"
    
    private var posts = [Post]() {
        didSet { collectionView.reloadData() }
    }
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        }
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    //MARK: - API
    
    func fetchPosts() {
        guard post == nil else {return}
        
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPosts()
        }
    }
    
    func checkIfUserLikedPosts() {
        self.posts.forEach { post in
            PostService.checkIfUserLikePost(post: post) { didLike in
                
                print("DEBUG: \(post.caption) - ----- --  \(didLike)")
                if let index = self.posts.firstIndex(where: { $0.postId == post.postId }) {
                    self.posts[index].didLike = didLike
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }
    
}

//MARK: - UICollectionView DataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.delegate = self
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        return cell
    }
}

//MARK: - UICollectionView Delegate FlowLayout  -- where we define size of cell

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 110 //60 for image 50 for buttons like comment
        return CGSize(width: width, height: height)
    }
}

//MARK: - FeedCellDelegate

extension FeedController: FeedCellDelegate {

    func cell(_ cell: FeedCell, watsToPushProfile post: Post) {
        UserService.fetchUserWithUid(uid: post.ownerUid) { user in
                    let controller = ProfileController(user: user)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
    }
    
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentsController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            PostService.likePost(post: post) { err in
                cell.likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .systemRed
                cell.viewModel?.post.likes = post.likes + 1
                self.collectionView.reloadData()
                
                NotificationService.uploadNotification(toUid: post.ownerUid, type: .like, post: post)
            }
        } else {
            PostService.unlikePost(post: post) { err in
                cell.likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
                self.collectionView.reloadData()
            }
        }
    }
    
    
}
