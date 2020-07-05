//
//  UserService.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/5/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            
            print("DEBUG: User's username is \(user.username)")
            print("DEBUG: User's full name is \(user.fullName)")
        }
    }
}
