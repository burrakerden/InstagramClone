//
//  CommentCell.swift
//  InstagramClone
//
//  Created by Burak Erden on 11.05.2023.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    //MARK: - Properties
    
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
//        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
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
        
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        profileImageView.setDimensions(height: 40, width: 40)
        
        usernameButton.centerY(inView: self, leftAnchor: profileImageView.rightAnchor, paddingLeft: 6)
        
        commentLabel.centerY(inView: self, leftAnchor: usernameButton.rightAnchor, paddingLeft: 6)
        commentLabel.anchor(right: rightAnchor, paddingRight: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {

    }

    //MARK: - Actions

}
