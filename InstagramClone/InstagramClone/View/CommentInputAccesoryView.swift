//
//  CommentInputAccesoryView.swift
//  InstagramClone
//
//  Created by Burak Erden on 11.05.2023.
//

import UIKit

protocol CommentInputAccesoryViewDelegate: AnyObject {
    func inputView(inputView: CommentInputAccesoryView, wantsToUploadComment comment: String)
}

class CommentInputAccesoryView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: CommentInputAccesoryViewDelegate?
    
    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter comment.."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.isScrollEnabled = false
        return tv
    }()
    
    lazy private var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handePostTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handePostTapped() {
        delegate?.inputView(inputView: self, wantsToUploadComment: commentTextView.text)
    }
    
    //MARK: - Helpers
    
    func clearCommentTextView() {
        commentTextView.text = ""
        commentTextView.placeholderLabel.isHidden = false
    }
    
}
