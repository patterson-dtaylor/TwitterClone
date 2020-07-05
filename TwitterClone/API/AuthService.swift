//
//  AuthService.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/4/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    let profileImage: UIImage
    let username: String
    let fullName: String
    let email: String
    let password: String
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, withPassword password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credientials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let imageData = credientials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credientials.email, password: credientials.password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = [
                        "profile image url": profileImageUrl,
                        "username": credientials.username,
                        "full name": credientials.fullName,
                        "email": credientials.email
                    ]
                    
                    // REF_USERS in Constants File
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
