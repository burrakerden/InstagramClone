//
//  CommentsController.swift
//  InstagramClone
//
//  Created by Burak Erden on 11.05.2023.
//

import UIKit

class CommentsController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let reuseIdentifier = "CommentCell"
    
    var post: Post
    
    private var comments = [Comment]()
    
    private lazy var commnetInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        cv.backgroundColor = .white
        return cv
    }()
    
    //MARK: - LifeCycle
    
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchComments()

    }
    
    override var inputAccessoryView: UIView? {
        get {return commnetInputView}
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - API
    
    func fetchComments() {
        CommentService.fetchComment(postID: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureCollectionView() {
        title = "Comments"
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    //MARK: - Actions
    
}

//MARK: - UICollectionViewDataSource

extension CommentsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserService.fetchUserWithUid(uid: comments[indexPath.row].uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension CommentsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(widht: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 20)
    }
    
    
}

//MARK: - CommentInputAccesoryViewDelegate

extension CommentsController: CommentInputAccesoryViewDelegate {
    func inputView(inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        guard let tab = self.tabBarController as? MainTabController else {return}
        guard let currentUser = tab.user else {return}
        
        showLoader(true)
        
        CommentService.uploadComment(comment: comment, postID: post.postId, user: currentUser) { error in
            self.showLoader(false)
            inputView.clearCommentTextView()
            
            NotificationService.uploadNotification(toUid: self.post.ownerUid, type: .comment, forUser: currentUser, post: self.post)

        }
    }
    
    
}
