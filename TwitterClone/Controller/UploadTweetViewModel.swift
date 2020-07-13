//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/13/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

enum UpLoadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweeViewModel {
    
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReplyLabel: Bool
    var replyText: String?
    
    init(config: UpLoadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's happening?"
            shouldShowReplyLabel = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet your reply..."
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
