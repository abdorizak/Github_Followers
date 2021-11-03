//
//  GFFollowerItemVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 11/3/21.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureitems()
    }
    
    private func configureitems() {
        itemInfoViewOne.set(ItemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(ItemInfoType: .following, withCount: user.following)
        actionBtn.set(backgroundColor: .systemGreen, title: "Github Followers")
        
    }
    
    override func actionBtnTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
