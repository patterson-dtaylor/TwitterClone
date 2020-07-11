//
//  ProfileFilterCell.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/10/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var option: ProfileFilterOptions! {
        didSet { titleLabel.text = option.description}
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "twitterPlaceholderColor")
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Tweets"
        return label
    }()
    
    override var isSelected: Bool {
        
        didSet {
            titleLabel.font = isSelected ? UIFont.systemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? UIColor(named: "twitterBlue") : UIColor(named: "twitterPlaceholderColor")
        }
        
    }
    
    //MARK: - LIfecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "twittercloneBG")
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
