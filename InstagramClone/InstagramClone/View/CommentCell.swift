//
//  CommentCell.swift
//  InstagramClone
//
//  Created by Burak Erden on 11.05.2023.
//

import UIKit
import SDWebImage

class CommentCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel: CommentViewModel? {
        didSet { configureUI() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "venom-7")
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    private let commentLabel: UILabel = {
        var label = UILabel()
        label.text = "[FirebaseMessaging][I-"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(usernameButton)
        addSubview(commentLabel)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 8)
        profileImageView.setDimensions(height: 40, width: 40)
        
        usernameButton.anchor(top: topAnchor, left: profileImageView.rightAnchor, paddingTop: 6, paddingLeft: 8)
        
        commentLabel.anchor(top: usernameButton.bottomAnchor, left: usernameButton.leftAnchor, right: rightAnchor, paddingTop: -4, paddingRight: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        guard let viewModel else {return}
        commentLabel.text = viewModel.commentText
        profileImageView.sd_setImage(with: viewModel.imageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    //MARK: - Actions
    
}
