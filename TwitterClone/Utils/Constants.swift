//
//  Constants.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/4/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Firebase

//standaard notation for Contstants file all cap letters and underscore between words
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")

let STORAGE_REF = Storage.storage().reference()
//Use underscores for storage names
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
