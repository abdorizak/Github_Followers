//
//  GFDataLoadingVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 2/24/22.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    var containerView: UIView!
    func showLoadingview() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8  }
        
        let activatyIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activatyIndicator)
        
        activatyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activatyIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activatyIndicator.centerXAnchor.constraint(equalTo: containerView  .centerXAnchor)
        ])
        
        activatyIndicator.startAnimating()
    }
    
    func dismissLoding() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}
