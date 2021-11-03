//
//  UIViewController+Ext.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/24/21.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlerVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
            
        }
    }
    
    func presentSafariVC(for url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
    
    func showLoadingview() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8  }
        
        let activatyIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activatyIndicator)
        
        activatyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activatyIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activatyIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activatyIndicator.startAnimating()   
    }
    
    func dismissLoding() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
}
