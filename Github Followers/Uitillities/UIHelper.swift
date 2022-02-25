//
//  UIHelper.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/28/21.
//

import UIKit

enum UIHelper {
    static func createThreeCulomnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let miniumItemSpacing: CGFloat = 10
        
        let availableWidth = width - (padding * 2) - (miniumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let FlowLayout = UICollectionViewFlowLayout()
        FlowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        FlowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return FlowLayout
    }
}
