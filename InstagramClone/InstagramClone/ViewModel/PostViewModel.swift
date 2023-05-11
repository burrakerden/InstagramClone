//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by Burak Erden on 8.05.2023.
//

import Foundation
import Firebase

struct PostViewModel {
    
    let post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: String {
        if post.likes == 1 {
            return "\(post.likes) like"
        } else {
            return "\(post.likes) likes"
        }
    }
    
    var userProfileImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    var date: Timestamp {
        return post.timestamp
    }
    
    

    
    
    
    init(post: Post) {
        self.post = post
    }
}
