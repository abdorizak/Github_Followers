//
//  FolloweListVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/24/21.
//

import UIKit

class FolloweListVC: UIViewController {

    enum Section { case main }
    
    var username: String!
    var followers = [Follower]()
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingview()
        NetworkManger.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoding()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happen", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeCulomnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as? FollowerCell
            
            cell?.set(follower: follower)
            
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
            
        }
    }
    
}


extension FolloweListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offSetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    
}
