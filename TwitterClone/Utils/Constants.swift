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
let REF_USER_TWEETS = DB_REF.child("user-tweets")
let REF_USER_FOLLOWERS = DB_REF.child("user-followers")
let REF_USER_FOLLOWING = DB_REF.child("user-following")
let REF_TWEET_REPLIES = DB_REF.child("tweet-replies")
let REF_USER_LIKES = DB_REF.child("user-likes")
let REF_TWEET_LIKES = DB_REF.child("tweet-likes")
let REF_NOTIFICATIONS = DB_REF.child("notifications")

let STORAGE_REF = Storage.storage().reference()
//Use underscores for storage names
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
