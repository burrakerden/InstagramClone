//
//  UserCellViewModel.swift
//  InstagramClone
//
//  Created by Burak Erden on 3.05.2023.
//

import Foundation

struct UserCellViewModel {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var profileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    
//    init(user: User) {
//        self.user = user
//    }
}
