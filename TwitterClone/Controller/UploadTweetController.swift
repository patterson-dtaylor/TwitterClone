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
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - Lifecycle
    
    //Itializes the user so data can pass between controllers without recalling the api.
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func cancelTweetButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sendTweetButtonPressed() {
        guard let tweet = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: tweet) { (error, ref) in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "twittercloneBG")
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
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
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "twittercloneBG")
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTweetButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendTweetButton)
    }
}
