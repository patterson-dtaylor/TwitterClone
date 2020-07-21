//
//  ProfileFilterView.swift
//  TwitterClone
//
//  Created by Taylor Patterson on 7/9/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProfileFilterCell"

protocol ProfileFilterViewDelegate: class {
    func filterView(_ view: ProfileFileterView, didSelect indexpath: Int)
}

class ProfileFileterView: UIView {
    //MARK: - Properties
    
    weak var delegate: ProfileFilterViewDelegate?
    
    lazy var collecitonView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "twittercloneBG")
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    private let underlineView: UIView = {
        let underlineview = UIView()
        underlineview.backgroundColor = UIColor(named: "twitterBlue")
        return underlineview
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collecitonView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collecitonView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collecitonView)
        collecitonView.addConstrantsToFillView(self)

    }
    
    override func layoutSubviews() {
        addSubview(underlineView)
        underlineView.anchor(
            left:leftAnchor,
            bottom: bottomAnchor,
            width: frame.width / 3,
            height: 2
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
}

//MARK: - UICollectionViewDataSource

extension ProfileFileterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
        
        let option = ProfileFilterOptions(rawValue: indexPath.row)
        cell.option = option
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ProfileFileterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collecitonView.cellForItem(at: indexPath)
        
        let xPosition = cell?.frame.origin.x ?? 0
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
        
        delegate?.filterView(self, didSelect: indexPath.row)
    }
}

//MARK: - UICollectionViewDelegateFlowlayout

extension ProfileFileterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(ProfileFilterOptions.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}




