//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Burak Erden on 2.05.2023.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageURL)
    }
    
    init(user: User) {
        self.user = user
    }
}
