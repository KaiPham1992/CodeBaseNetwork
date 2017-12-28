//
//  UIViewController+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit

extension UIViewController {
    static func initFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ : T.Type) -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib(self)
    }
    
    func showHUD() {
        
    }
    
    func hideHUD() {
        
    }
}


extension UIViewController {
    func push(controller: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool = true ) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func present(controller: UIViewController, animated: Bool = true) {
        self.present(controller, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool = true) {
        self.dismiss(animated: animated, completion: nil)
    }
}
