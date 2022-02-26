//
//  UITableView+Ext.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 2/26/22.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCell() {
        tableFooterView = UIView(frame: .zero)
    }
}
