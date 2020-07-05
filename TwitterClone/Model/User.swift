//
//  User.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/5/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let profileImageUrl: String
    let username: String
    let fullName: String
    let email: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.profileImageUrl = dictionary["profile image url"] as! String ?? ""
        self.username = dictionary["username"] as! String ?? ""
        self.fullName = dictionary["full name"] as! String ?? ""
        self.email = dictionary["email"] as! String ?? ""
    }
}
