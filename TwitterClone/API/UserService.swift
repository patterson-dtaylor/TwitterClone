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
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            
            completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        
        var users = [User]()
        
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dicitonary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dicitonary)
            
            users.append(user)
            
            completion(users)
        }
    }
}
