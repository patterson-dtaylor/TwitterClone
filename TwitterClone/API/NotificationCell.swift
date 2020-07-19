//
//  NotificationCel.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/17/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

protocol NotificaitonCellDelegate: class {
    func didTapProfileImage(_ cell: NotificationCell)
    func didTapFollow(_ cell: NotificationCell)
}

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    
    var notification: Notification? {
        didSet { configure() }
    }
    
    weak var delegate: NotificaitonCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.layer.backgroundColor = UIColor(named: "twitterBlue")?.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
        
    }()
    
    var notificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Some text notificiaton message."
        
        return label
    }()

    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.setTitleColor(UIColor(named: "twitterBlue"), for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "twitterBlue")?.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)

        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, notificationLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        addSubview(stack)
        stack.centerY(
            inview: self,
            leftAnchor: leftAnchor,
            paddingLeft: 12
        )
        
        stack.anchor(right: rightAnchor, paddingRight: 12)
        
        addSubview(followButton)
        followButton.centerY(inview: self)
        followButton.setDimensions(width: 88, height: 30)
        followButton.layer.cornerRadius = 30 / 2
        followButton.anchor(right: rightAnchor, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let notification = notification else { return }
        
        let viewModel = NotificationViewModel(notification: notification)
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        
        notificationLabel.attributedText = viewModel.notificationText
        
        followButton.isHidden = viewModel.shouldHideFollowButton
        followButton.setTitle(viewModel.followButtonText, for: .normal)
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        delegate?.didTapProfileImage(self)
    }
    
    @objc func handleFollowTapped() {
        delegate?.didTapFollow(self)
    }
    
}
