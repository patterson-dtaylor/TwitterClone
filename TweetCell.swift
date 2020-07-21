//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/6/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func handleProfileImageTapped(_ cell: TweetCell)
    func handleReplyTapped(_ cell: TweetCell)
    func handleLikeTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    weak var delegate: TweetCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.layer.backgroundColor = UIColor(named: "twitterBlue")?.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
        
    }()
    
    private let infoLabel = UILabel()
    
    private let replyLabel: UILabel = {
        let label = UILabel()
        label.tintColor = UIColor(named: "twitterPlaceholderColor")
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "I'm calling the phone!"
        
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = Utilities().tweetCellButtons(withImageName: "bubble.left", withcolorName: "twitterPlaceholderColor")
        
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = Utilities().tweetCellButtons(withImageName: "repeat", withcolorName: "twitterPlaceholderColor")
        
        button.addTarget(self, action: #selector(retweetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = Utilities().tweetCellButtons(withImageName: "heart", withcolorName: "twitterPlaceholderColor")
        
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = Utilities().tweetCellButtons(withImageName: "square.and.arrow.up", withcolorName: "twitterPlaceholderColor")
        
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()

    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "twittercloneBG")
        
        let captionStack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        captionStack.axis = .vertical
        captionStack.distribution = .fillProportionally
        captionStack.spacing = 4
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionStack])
        imageCaptionStack.distribution = .fillProportionally
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        addSubview(stack)
        stack.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 4,
            paddingLeft: 12,
            paddingRight: 50
        )
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
        let underlineview = UIView()
        underlineview.backgroundColor = .systemGroupedBackground
        addSubview(underlineview)
        underlineview.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            height: 1
        )
        
        let tweetCellButtonsStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        addSubview(tweetCellButtonsStack)
        tweetCellButtonsStack.axis = .horizontal
        tweetCellButtonsStack.spacing = 72
        tweetCellButtonsStack.centerX(inView: self)
        tweetCellButtonsStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func commentButtonTapped() {
        delegate?.handleReplyTapped(self)
    }
    
    @objc func retweetButtonTapped() {
        print("DEBUG: Retweet button pressed!")
    }
    
    @objc func likeButtonTapped() {
        delegate?.handleLikeTapped(self)
    }
    
    @objc func shareButtonTapped() {
        print("DEBUG: Share button pressed!")
    }
    
    @objc func handleProfileImageTapped() {
        delegate?.handleProfileImageTapped(self)
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        infoLabel.attributedText = viewModel.userInfoText
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        replyLabel.isHidden = viewModel.shouldHideReplyLabel
        replyLabel.text = viewModel.replyText
        
    }
    
    func tweetTimestampFormatter(withTimestamp timestamp: Date) -> String {
        let timestamp = timestamp
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        let dateTimeString = formatter.string(from: timestamp)
        
        return dateTimeString
    }
}
