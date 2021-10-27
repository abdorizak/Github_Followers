//
//  FolloweListVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/24/21.
//

import UIKit

class FolloweListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        NetworkManger.shared.getFollowers(for: username, page: 1) { followers, errormessage in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad stuff Happed", message: errormessage!.rawValue, buttonTitle: "ok")
                return
            }
            
            print("Followers.count =\(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
