//
//  UIScreen+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit

extension UIScreen {
    class func screenWidth() -> CGFloat {
        return main.bounds.width
    }
    
    class func screenHeight() -> CGFloat {
        return main.bounds.height
    }
}
