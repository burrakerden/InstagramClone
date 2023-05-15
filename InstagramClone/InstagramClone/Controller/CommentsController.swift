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
    
    private lazy var commnetInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        cv.backgroundColor = .white
        return cv
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

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
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension CommentsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}

//MARK: - CommentInputAccesoryViewDelegate

extension CommentsController: CommentInputAccesoryViewDelegate {
    func inputView(inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        inputView.clearCommentTextView()
    }
    
    
}
