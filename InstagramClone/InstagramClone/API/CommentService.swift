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
    
    static func fetchComment(postID: String, completion: @escaping([Comment]) -> Void) {
        var comments = [Comment]()
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            })
            completion(comments)
        }
    }

}
