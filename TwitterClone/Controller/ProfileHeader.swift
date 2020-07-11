//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/8/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handleDismisal()
}

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let filterBar = ProfileFileterView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "twitterBlue")
        
        view.addSubview(backButton)
        backButton.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: 42,
            paddingLeft: 16,
            width: 30,
            height: 30
        )
        
        view.addSubview(profileImageView)
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        
        return iv
    }()
    
    private lazy var followOrUnfollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor(named: "twitterBlue")?.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(UIColor(named: "twitterBlue"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleFollowOrUnfollow), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var fullName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var username: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "twitterPlaceholderColor")
        
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes."
        
        return label
    }()
    
    private let underlineView: UIView = {
        let underlineview = UIView()
        underlineview.backgroundColor = UIColor(named: "twitterBlue")
        return underlineview
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "2 Following"
        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0 Followers"
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handelFollowersTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        
        return label
    }()
    
    //MARK: - Lifecyle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterBar.delegate = self
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
        addSubview(profileImageView)
        profileImageView.anchor(
            top: containerView.bottomAnchor,
            left: leftAnchor,
            paddingTop: -24,
            paddingLeft: 8,
            width: 80,
            height: 80
        )
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(followOrUnfollowButton)
        followOrUnfollowButton.anchor(
            top:containerView.bottomAnchor,
            right: rightAnchor,
            paddingTop: 12,
            paddingRight: 12,
            width: 100,
            height: 36
        )
        followOrUnfollowButton.layer.cornerRadius = 36 / 2
        
        let userDetailsStack = UIStackView(arrangedSubviews: [fullName, username, bioLabel])
        userDetailsStack.axis = .vertical
        userDetailsStack.distribution = .fill
        userDetailsStack.spacing = 4
        
        addSubview(userDetailsStack)
        userDetailsStack.anchor(
            top: profileImageView.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 8,
            paddingLeft: 12,
            paddingRight: 12
        )
        
        let followStack = UIStackView(arrangedSubviews: [followersLabel, followingLabel])
        followStack.axis = .horizontal
        followStack.distribution = .fillEqually
        followStack.spacing = 8
        
        addSubview(followStack)
        followStack.anchor(
            top: userDetailsStack.bottomAnchor,
            left: leftAnchor,
            paddingTop: 8,
            paddingLeft: 12
        )
        
        addSubview(filterBar)
        filterBar.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            height: 50
        )
        
        addSubview(underlineView)
        underlineView.anchor(left:leftAnchor, bottom: bottomAnchor, width: frame.width / 3, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    @objc func handleDismissal() {
        delegate?.handleDismisal()
    }
    
    @objc func handleFollowOrUnfollow() {
        print("DEBUG: Follow or Unfollow.")
    }
    
    @objc func handleFollowingTapped() {
        print("DEBUG: Who the user is following.")
    }
    
    @objc func handelFollowersTapped() {
        print("DEBUG: Who is following the user.")
    }
    
    func configure() {
        guard let user = user else { return }

        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        followOrUnfollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)

        followersLabel.attributedText = viewModel.followersString
        followingLabel.attributedText = viewModel.followingString
        
        fullName.text = user.fullName
        username.text = viewModel.usernameText
        
    }
}

//MARK: - ProfileFilterViewDelegate

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFileterView, didSelect indexpath: IndexPath) {
        guard let cell = view.collecitonView.cellForItem(at: indexpath) as? ProfileFilterCell else { return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}
