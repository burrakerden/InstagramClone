//
//  UserCell.swift
//  InstagramClone
//
//  Created by Burak Erden on 3.05.2023.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class UserCell: UITableViewCell {
    
    //MARK: - Properties
    
    var viewModel: UserCellViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 8)
        profileImageView.centerY(inView: self)
        profileImageView.setDimensions(height: 44, width: 44)
        profileImageView.layer.cornerRadius = 44 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 4

        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        
        
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel else {return}
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname
    }

}
