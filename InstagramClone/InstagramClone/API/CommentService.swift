//
//  CommentService.swift
//  InstagramClone
//
//  Created by Burak Erden on 15.05.2023.
//

import UIKit
import Firebase

struct CommentService {
    
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
            let data = ["commentText": comment,
                        "timestamp": Timestamp(date: Date()),
                        "uid": uid,
                        "username": user.username,
                        "profileImageUrl": user.profileImageURL] as [String : Any]
                                        
            
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
        
    }
    
    static func fetchComment(uid: String, user: User, completion: @escaping(FirestoreCompletion)) {
    }

}
