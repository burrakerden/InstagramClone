//
//  User.swift
//  InstagramClone
//
//  Created by Burak Erden on 2.05.2023.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullname: String
    let profileImageURL: String
    let username: String
    let uid: String
    
    var isFollowed: Bool = false
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid}
    
    var stats: UserStats!
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
        self.stats = UserStats(following: 0, followers: 0, post: 0)
        
    }
}

struct UserStats {
    var following: Int
    var followers: Int
    var post: Int
}
