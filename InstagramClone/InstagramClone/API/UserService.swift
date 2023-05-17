//
//  UserService.swift
//  InstagramClone
//
//  Created by Burak Erden on 2.05.2023.
//

import Foundation
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    
    static func fetchUserWithUid(uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else {return}
            
            let user = User(dictionary: dictionary)
            completion(user)
            
        }
        
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot else {return}
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else {return}
            completion(isFollowed)
        }
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            let followers = snapshot?.documents.count ?? 0
            
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
                let followings = snapshot?.documents.count ?? 0
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
                    let post = snapshot?.documents.count ?? 0
                    completion(UserStats(following: followings, followers: followers, post: post))
                }
            }
        }
        
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete() { error in
            if let error = error {
                print("Error removing document: \(error.localizedDescription)")
            } else {
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
            }
        }
    }
}
