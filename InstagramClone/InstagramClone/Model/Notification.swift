//
//  Notification.swift
//  InstagramClone
//
//  Created by Burak Erden on 23.05.2023.
//

import Foundation
import Firebase

enum NotifiationType: Int {
    case like
    case follow
    case comment
    
    var NotificationMessage: String {
        switch self {
        case.like: return " liked your post"
        case.follow: return " following you"
        case.comment: return " commented on your post"
        }
    }
}

struct Notification {
    let uid: String
    var postImageUrl: String?
    var postId: String?
    var timestamp: Timestamp
    let type: NotifiationType
    let id: String
    let userProfileImageUrl: String
    let username: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.type = NotifiationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.id = dictionary["id"] as? String ?? ""
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""

    }
}
