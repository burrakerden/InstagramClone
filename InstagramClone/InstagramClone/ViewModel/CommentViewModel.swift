//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Burak Erden on 16.05.2023.
//

import Foundation
import Firebase

struct CommentViewModel {
    
    let comment: Comment
    
    var commentText: String {
        return comment.commentText
    }
    
    var imageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    var uid: String {
        return comment.uid
    }
    
    var username: String {
        return comment.username
    }

    var timestamp: Timestamp {
        return comment.timestamp
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func size(widht: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(widht)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
