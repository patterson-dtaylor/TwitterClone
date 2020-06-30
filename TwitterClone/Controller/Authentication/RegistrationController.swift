//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 6/29/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "twittercloneBG")
    }
}
