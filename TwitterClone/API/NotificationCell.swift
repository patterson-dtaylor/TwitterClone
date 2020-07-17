//
//  NotificationCel.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/17/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties
    
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
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Some text notificiaton message."
        
        return label
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        print("DEBUG: Profile image handle tapped!")
    }
    
}
