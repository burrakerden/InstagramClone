//
//  PostService.swift
//  InstagramClone
//
//  Created by Burak Erden on 8.05.2023.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { imageURL in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageURL,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageURL,
                        "ownerUsername": user.username]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
        
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
            
        }
    }
}
