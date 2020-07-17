//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/6/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class UploadTweetContoller: UIViewController {
    
    //MARK: - Properties
    
    private let user: User
    
    private let config: UpLoadTweetConfiguration
    
    private lazy var viewModel = UploadTweeViewModel(config: config)
    
    private lazy var sendTweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "twitterBlue")
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(sendTweetButtonPressed), for: .touchUpInside)
        
       return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.layer.backgroundColor = UIColor(named: "twitterBlue")?.cgColor
        
        return iv
    }()
    
    private lazy var replyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "twitterPlaceholderColor")
        label.text = "Replying to @bighead"
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        return label
    }()
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - Lifecycle
    
    //Itializes the user so data can pass between controllers without recalling the api.
    init(user: User, config: UpLoadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        switch config {
        case .tweet:
            print("DEBUG: Config is tweet")
        case .reply(let tweet):
            print("DEBUG: Replying to \(tweet.caption)")
        }
    }
    
    //MARK: - Selectors
    
    @objc func cancelTweetButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sendTweetButtonPressed() {
        guard let tweet = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: tweet, type: config) { (error, ref) in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
            }
            
            if case .reply(let tweet) = self.config {
                NotificationService.shared.uploadNotification(type: .reply, tweet: tweet)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "twittercloneBG")
        configureNavigationBar()
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        sendTweetButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeHolderLabel.text = viewModel.placeholderText
        
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "twittercloneBG")
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTweetButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendTweetButton)
    }
}
