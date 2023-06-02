//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Burak Erden on 7.04.2023.
//

import UIKit
import SDWebImage

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
    func cell(_ cell: FeedCell, watsToPushProfile post: Post)
}

class FeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: FeedCellDelegate?
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 20
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(showUserProfile))
        iv.addGestureRecognizer(recognizer)
        
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(showUserProfile), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
//        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "send2"), for: .normal)
        //        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private let likeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        //        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12, width: 40, height: 40)
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionButtons()
        
        addSubview(likeLabel)
        likeLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likeLabel.bottomAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        addSubview(saveButton)
        saveButton.anchor(top: postImageView.bottomAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 10)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func showUserProfile() {
        guard let viewModel else {return}
        delegate?.cell(self, watsToPushProfile: viewModel.post)
    }
    
    @objc func didTapComments() {
        guard let viewModel else {return}
        delegate?.cell(self, wantsToShowCommentsFor: viewModel.post)
    }
    
    @objc func didTapLike() {
        guard let viewModel else {return}
        delegate?.cell(self, didLike: viewModel.post)
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel else {return}
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
        postTimeLabel.text = viewModel.timestampString
        likeLabel.text = viewModel.likes
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
    }
    
    func configureActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
}
