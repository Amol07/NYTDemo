//
//  TableView+Ext.swift
//  NYT Demo
//
//  Created by Amol Prakash on 10/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(type: T.Type, bundle: Bundle? = nil) {
        let identifier = String(describing: type)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
