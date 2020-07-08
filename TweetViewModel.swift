//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/7/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [
            .second,
            .minute,
            .hour,
            .day,
            .weekOfMonth
        ]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        
        let now = Date()
        
        return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullName, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(named: "twitterPlaceholderColor") ?? UIColor.lightGray
        ]))
        
        title.append(NSAttributedString(string: " • \(timestamp)", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(named: "twitterPlaceholderColor") ?? UIColor.lightGray
        ]))
        
        return title
        
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
