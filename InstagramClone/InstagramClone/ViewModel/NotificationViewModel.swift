//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Burak Erden on 24.05.2023.
//

import UIKit

struct NotificationViewModel {
    
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? {return URL(string: notification.postImageUrl ?? "")}
    
    var profileImageUrl: URL? {return URL(string: notification.userProfileImageUrl)}
        
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.NotificationMessage
        let time = "2m"
        return attributedStatText(username: username, message: message, time: time)
    }

    func attributedStatText(username: String, message: String, time: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "   \(time)", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))

        return attributedText
    }
    
    var shouldHidePostImage: Bool {return notification.type == .follow}
    
    var followButtonText: String { return notification.userIsFollowed ? "Following" : "Follow"}
    var followButtonBgColor: UIColor { return notification.userIsFollowed ? .white : .systemBlue}
    var followButtonTextColor: UIColor { return notification.userIsFollowed ? .black : .white}

}
