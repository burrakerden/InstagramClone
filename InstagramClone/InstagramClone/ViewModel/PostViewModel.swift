//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by Burak Erden on 8.05.2023.
//

import Firebase
import UIKit

struct PostViewModel {
    
    let post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var caption: String { return post.caption }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    
    var username: String { return post.ownerUsername }
    
    //    var date: Timestamp { return post.timestamp }
    
    var likes: String {
        if post.likes == 1 {
            return "\(post.likes) like"
        } else {
            return "\(post.likes) likes"
        }
    }
    
    var likeButtonTintColor: UIColor { return post.didLike ? .red : .black }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    
    init(post: Post) {
        self.post = post
    }
}
