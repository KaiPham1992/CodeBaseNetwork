//
//  KBaseViewController.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

enum StyleNavigation {
    case left
    case right
}

class KBaseViewController: UIViewController {
    
    func setUpNavigation(navigationColor: UIColor = UIColor.gray, backgroundColor: UIColor = UIColor.white) {
        //---
        self.navigationController?.navigationBar.barTintColor = navigationColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = backgroundColor
    }
    
    // No use Cocoa Action
    func addButtonImageToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
    func addTwoButtonImageToNavigation(image1: UIImage, action1: Selector?, image2: UIImage, action2: Selector?) {
        let btn1 = UIButton()
        btn1.setImage(image1, for: .normal)
        if let _action = action1 {
            btn1.addTarget(self, action: _action, for: .touchUpInside)
        }
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        btn1.contentHorizontalAlignment = .right
        let button1 = UIBarButtonItem(customView: btn1)
        
        //---
        let btn2 = UIButton()
        btn2.setImage(image2, for: .normal)
        if let _action = action2 {
            btn2.addTarget(self, action: _action, for: .touchUpInside)
        }
        btn2.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn2.contentHorizontalAlignment = .right
        
        let button2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.rightBarButtonItems = [button1, button2]
    }
    
    func addButtonTextToNavigation(title: String, textColor: UIColor, font: UIFont, style: StyleNavigation, action: Selector?) {
        let btn = UIButton()
        btn.setAttributed(title: title, color: textColor, font: font)
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    func setTitle(title: String, textColor: UIColor = UIColor.black, font: UIFont) {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        lb.font = font
        lb.text = title
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.textColor = textColor
        lb.sizeToFit()
        
        self.navigationItem.titleView = lb
    }
    
    // use Cocoa Action
    func addButtonTextToNavigation(title: String, textColor: UIColor, font: UIFont, style: StyleNavigation, action: CocoaAction?) {
        var btn = UIButton()
        btn.setAttributed(title: title, color: textColor, font: font)
        btn.rx.action = action
        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    func addButtonImageToNavigation(image: UIImage, style: StyleNavigation, action: CocoaAction?) {
        var btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.rx.action = action
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
}
