//
//  FeedController.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 6/28/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = UIColor(named: "twittercloneBG")
        
        let imageView = UIImageView(image: UIImage(named: "smallLogo"))
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
    }
 
}
