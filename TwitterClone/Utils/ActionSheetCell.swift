//
//  ActionSheetCell.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/14/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    //MARK: - Properties
    
    var option: ActionSheetOptions? {
        didSet {
            configure()
        }
    }
    
    private let optionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "logoBlue")
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Test Option"
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(optionImageView)
        optionImageView.centerY(inview: self)
        optionImageView.anchor(left: leftAnchor, paddingLeft: 8)
        optionImageView.setDimensions(width: 36, height: 36)

        addSubview(titleLabel)
        titleLabel.center(inView: self)
        titleLabel.anchor(left: optionImageView.rightAnchor, paddingLeft: 12)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper
    
    func configure() {
        titleLabel.text = option?.description
    }
}
