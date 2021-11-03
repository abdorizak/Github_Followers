//
//  UserInfoVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/30/21.
//

import UIKit


protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAligment: .center)
    var itemViews:[UIView]  = []
    
    var username: String!
    weak var delegate: FolloweListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let DoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = DoneBtn
    }
    
    func getUserInfo() {
        NetworkManger.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let err):
                self.presentGFAlertOnMainThread(title: "Something going Wrong", message: err.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    
    func configureUIElements(with user: User) {
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC , to: self.itemViewTwo)
        self.dateLabel.text = "Github Since \(user.created_at.convertToDisplayFormar())"
    }
    
    
    func layoutUI() {
        let padding: CGFloat     = 20
        let itemHeight: CGFloat  = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel ]
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        // show Safari ViewController
        guard let url = URL(string: user.html_url) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "the url attached to the user is Invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(for: url)
    }
    
    func didTapGetFollowers(for user: User) {
        // disMissVC
        //tell the follower Screen to new User
        guard user.following != 0 else{
            presentGFAlertOnMainThread(title: "No Followers", message: "this user has no followers 😁", buttonTitle: "ok ")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
        
    
    
    
        
    
    
}

