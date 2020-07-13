//
//  TweetHeader.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/13/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

class TweetHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
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
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Full Name"
        
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "twitterPlaceholderColor")
        label.text = "User Name"
        
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Some text from Bighead goes here: TEST!"
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "twitterPlaceholderColor")
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "6:53AM - 7/13/20"
        
        return label
    }()
    
    private let optionsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor(named: "twitterPlaceholderColor")
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        return button
    }()
    
    private let retweetsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "3 Retweets"
        
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0 Likes"
        
        return label
    }()
    
    private lazy var statsView: UIView = {
        let view = UIView()
        
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        view.addSubview(divider1)
        divider1.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            height: 1.0
        )
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inview: view)
        stack.anchor(left: view.leftAnchor, paddingLeft: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        view.addSubview(divider2)
        divider2.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 8,
            height: 1.0
        )
        
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "twittercloneBG")
        
        let labelStack = UIStackView(arrangedSubviews: [fullNameLabel, usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 16,
            paddingLeft: 16
        )
        
        addSubview(captionLabel)
        captionLabel.anchor(
            top: stack.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        addSubview(dateLabel)
        dateLabel.anchor(
            top: captionLabel.bottomAnchor,
            left: leftAnchor,
            paddingTop: 20,
            paddingLeft: 16
        )
        
        addSubview(optionsButton)
        optionsButton.centerY(inview: stack)
        optionsButton.anchor(right: rightAnchor, paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(
            top: dateLabel.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 20,
            height: 40
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        print("DEBUG: Go to profile!")
    }
    
    @objc func showActionSheet() {
        print("DEBUG: Show action sheet!")
    }
}
