//
//  NotificationCell.swift
//  InstagramClone
//
//  Created by Burak Erden on 22.05.2023.
//

import UIKit
import SDWebImage

protocol NotificationCellDelegate: AnyObject {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String)
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String)
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String)
}

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    
    weak var delegate: NotificationCellDelegate?
        
    var viewModel: NotificationViewModel? {
        didSet {configureUI()}
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 2
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        iv.addGestureRecognizer(recognizer)
        return iv
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handeFollowTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 8)
        profileImageView.centerY(inView: self)
        profileImageView.setDimensions(height: 44, width: 44)
        profileImageView.layer.cornerRadius = 44 / 2
        
        addSubview(infoLabel)
        infoLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right: rightAnchor, paddingRight: 12, width: 100, height: 32)
        
        addSubview(postImageView)
        postImageView.centerY(inView: self)
        postImageView.anchor(right: rightAnchor, paddingRight: 12, width: 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        guard let viewModel else {return}
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        postImageView.sd_setImage(with: viewModel.postImageUrl)
        infoLabel.attributedText = viewModel.notificationMessage
        postImageView.isHidden = viewModel.shouldHidePostImage
        followButton.isHidden = !viewModel.shouldHidePostImage
        viewModel.shouldHidePostImage ? infoLabel.anchor(right: rightAnchor, paddingRight: 116) : infoLabel.anchor(right: rightAnchor, paddingRight: 56)
    }
    
    
    //MARK: - Actions
    
    @objc func handeFollowTapped() {
        guard let viewModel else {return}
        delegate?.cell(self, wantsToFollow: viewModel.notification.uid)
    }
    
    @objc func handlePostTapped() {
        guard let postId = viewModel?.notification.postId else {return}
        delegate?.cell(self, wantsToViewPost: postId)
    }
    
}
