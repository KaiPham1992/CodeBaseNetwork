//
//  UICollectionView+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit

// MARK: Cell
extension UICollectionViewCell {
    
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

// MARK: collection
extension UICollectionView {
    // cell
    func registerCustomCell<T: UICollectionViewCell>(_: T.Type, fromNib: Bool) {
        if fromNib {
            self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueCustomCell<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
        
        return cell as! T
    }
    
    // register header - footer
    func registerCustomHeader<T: UICollectionViewCell>(_: T.Type, fromNib: Bool) {
        if fromNib {
           registerCustomHeaderFooter(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, fromNib: true)
        } else {
            registerCustomHeaderFooter(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, fromNib: false)
        }
    }
    
    func registerCustomFooter<T: UICollectionViewCell>(_: T.Type, fromNib: Bool) {
        if fromNib {
            registerCustomHeaderFooter(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, fromNib: true)
        } else {
            registerCustomHeaderFooter(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, fromNib: false)
        }
    }
    
    private func registerCustomHeaderFooter<T: UICollectionViewCell>(_: T.Type, forSupplementaryViewOfKind: String, fromNib: Bool) {
        if fromNib {
            self.register(T.nib, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.identifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueCustomHeader<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueCustomHeaderFooter(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, indexPath: indexPath)
    }
    
    func dequeueCustomFooter<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueCustomHeaderFooter(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, indexPath: indexPath)
    }
    
    // dequeue header - footer
    private func dequeueCustomHeaderFooter<T: UICollectionViewCell>(_: T.Type, forSupplementaryViewOfKind: String, indexPath: IndexPath) -> T {
        let headerFooter = self.dequeueReusableSupplementaryView(ofKind: forSupplementaryViewOfKind, withReuseIdentifier: T.identifier, for: indexPath)
        
        return headerFooter as! T
    }
   
    
}
