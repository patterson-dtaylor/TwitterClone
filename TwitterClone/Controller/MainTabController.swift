//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 6/28/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
    }
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        
        let feed = templateNavigationController(image: "house", rootViewController: FeedController())
        
        let explore = templateNavigationController(image: "magnifyingglass", rootViewController: ExploreController())
        
        let notifications = templateNavigationController(image: "heart", rootViewController: NotificationsController())
        
        let conversations = templateNavigationController(image: "envelope", rootViewController: ConverstationsController())
        
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    func templateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.navigationBar.barTintColor = UIColor(named: "twittercloneBG")
        return nav
        
    }

}
