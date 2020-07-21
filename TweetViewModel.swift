//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/7/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

struct TweetViewModel {
    
    //MARK: - Properties
    
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
    
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a • MM/dd/yyyy"
        
        return formatter.string(from: tweet.timestamp)
    }
    
    var retweetsAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.retweetCount, text: "Retweets")
    }
    
    var likesAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.likes, text: "Likes")
    }
    
    var usernameText: String {
        return "@\(user.username)"
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
    
    var likeButtonTintColor: UIColor {
        return (tweet.didLike ? .red : UIColor(named: "twitterPlaceholderColor"))!
    }
    
    var likeButtonImage: UIImage {
        let imageName = tweet.didLike ? "heart.fill" : "heart"
        return UIImage(systemName: imageName)!
    }
    
    var shouldHideReplyLabel: Bool {
        return !tweet.isReply
    }
    
    var replyText: String? {
        guard let replyingToUsername = tweet.replyingTo else { return nil }
        return "→ replying to @\(replyingToUsername)"
    }
    
    //MARK: - LifeCycle
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor(named: "twitterPlaceholderColor") ?? UIColor.lightGray]))
        
        return attributedTitle
    }
    
    //MARK: - Helpers
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        measurementLabel.text = tweet.caption
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
