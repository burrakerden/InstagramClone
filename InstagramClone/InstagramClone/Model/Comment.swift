//
//  Comment.swift
//  InstagramClone
//
//  Created by Burak Erden on 16.05.2023.
//

import Foundation
import Firebase

struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let commentText: String
    
    init(dictionary: [String:Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.commentText = dictionary["commentText"] as? String ?? ""
    }
}
