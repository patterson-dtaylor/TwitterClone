//
//  ActionSheetViewModel.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/14/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

struct ActionSheetViewModel {
    
    private var user: User
    
    var options: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            if self.user.isFollowed {
                results.append(.unfollow(self.user))
            } else {
                results.append(.follow(self.user))
            }
            
//            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
//            results.append(followOption)
        }
        
        results.append(.report)
        
        return results
    }
    
    init(user: User) {
        self.user = user
    }
}
    
enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case report
    case delete
    
    var description: String {
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "Unfollow @\(user.username)"
        case .report:
            return "Report Tweet"
        case .delete:
            return "Delete Tweet"
        }
    }
}
