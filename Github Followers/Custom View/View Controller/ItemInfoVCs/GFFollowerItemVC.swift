//
//  GFFollowerItemVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 11/3/21.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject { 
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    weak var delegate: GFFollowerItemVCDelegate!
    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
