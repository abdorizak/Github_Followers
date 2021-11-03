//
//  GFRepoItemVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 11/3/21.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureitems()
    }
    
    private func configureitems() {
        itemInfoViewOne.set(ItemInfoType: .repos, withCount: user.public_repos)
        itemInfoViewTwo.set(ItemInfoType: .gists, withCount: user.public_gists)
        actionBtn.set(backgroundColor: .systemPurple, title: "Github Profile")
        
    }
}
