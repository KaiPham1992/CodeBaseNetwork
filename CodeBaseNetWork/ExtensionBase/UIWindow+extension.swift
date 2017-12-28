//
//  UIWindow+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    func show(rootViewController: UIViewController, animated: Bool = true , animationType: String = kCATransitionFromTop) {
        if animated {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            animation.type = kCATransitionFade
            animation.subtype = animationType
            animation.duration = 0.4
            self.layer.add(animation, forKey: "transitionViewAnimation")
        } else {
            self.layer.removeAllAnimations()
        }
        //---
        
        self.rootViewController = rootViewController
        self.makeKeyAndVisible()
    }
}
