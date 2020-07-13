//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/6/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class CaptionTextView: UITextView {
    
    //MARK: - Properties
    
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "twitterPlaceholderColor")
        label.text = "What's happening?"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = UIColor(named: "twittercloneBG")
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        backgroundColor = UIColor(named: "twittercloneBG")
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            paddingTop: 8,
            paddingLeft: 8
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
