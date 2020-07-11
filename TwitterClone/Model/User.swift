//
//  User.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/5/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid: String
    var profileImageUrl: URL?
    let username: String
    let fullName: String
    let email: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.username = dictionary["username"] as? String ?? ""
        self.fullName = dictionary["full name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profile image url"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
        
    }
}
