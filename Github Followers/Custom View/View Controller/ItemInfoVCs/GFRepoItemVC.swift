//
//  GFRepoItemVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 11/3/21.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemVCDelegate!
    
    init(user: User, delegate: GFRepoItemVCDelegate) {
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
        itemInfoViewOne.set(ItemInfoType: .repos, withCount: user.public_repos)
        itemInfoViewTwo.set(ItemInfoType: .gists, withCount: user.public_gists)
        actionBtn.set(backgroundColor: .systemPurple, title: "Github Profile")
        
    }
    
    override func actionBtnTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
