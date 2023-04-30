//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by Burak Erden on 27.04.2023.
//

import Foundation
import UIKit

class ProfileCell: UICollectionViewCell {
    
    //MARK: - Properties

    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    

    //MARK: - Helpers
}
