//
//  UITable+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit

// MARK: Cell
extension UITableViewCell {
    
    static var className: String {
        return String(describing: self)
    }
    
    static var identifier: String {
        return self.className
    }
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}

// MARK: Table
extension UITableView {
    
    // Cell
    func registerCustomCell<T: UITableViewCell>(_: T.Type, fromNib: Bool) {
        if fromNib {
            self.register( T.nib, forCellReuseIdentifier: T.identifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueCustomCell<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        
        return cell as! T
    }
    
}


