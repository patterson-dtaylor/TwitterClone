//
//  Tweet.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/6/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

struct Tweet {
    let tweetID: String
    let caption: String
    let likes: Int
    let retweetCount: Int
    var timestamp: Date!
    let uid: String
    let user: User
    
    init(user: User, tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
