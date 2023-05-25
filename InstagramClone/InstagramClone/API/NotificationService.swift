//
//  NotificationService.swift
//  InstagramClone
//
//  Created by Burak Erden on 23.05.2023.
//

import Foundation
import Firebase

struct NotificationService {
    
    static func uploadNotification(toUid uid: String, type: NotifiationType, forUser: User, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        guard uid != currentUid else {return}
        
//        UserService.fetchUserWithUid(uid: currentUid) { user in
            let docRef =  COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
            
            var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                       "uid": currentUid,
                                       "type": type.rawValue,
                                       "id" : docRef.documentID,
                                       "userProfileImageUrl": forUser.profileImageURL,
                                       "username": forUser.username]
            if let post = post {
                data["postId"] = post.postId                // ----> how to add item to data
                data["postImageUrl"] = post.imageUrl
            }
                
            docRef.setData(data)
//        }
        

    }
    
    static func fetchNotification(completion: @escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").getDocuments { snapshot, err in
            guard let documents = snapshot?.documents else {return}
            let notifications = documents.map({ Notification(dictionary: $0.data()) })
            completion(notifications)
        }
    }

}
