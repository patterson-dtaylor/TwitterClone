//
//  UserCell.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/11/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    //MARK: - Properties
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 40, height: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.layer.backgroundColor = UIColor(named: "twitterBlue")?.cgColor
        
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "USERNAME"
        
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "FULL NAME"
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        backgroundColor = .systemPurple
        
        addSubview(profileImageView)
        profileImageView.centerY(inview: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullNameLabel])
        addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 2
        stack.centerY(inview: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
