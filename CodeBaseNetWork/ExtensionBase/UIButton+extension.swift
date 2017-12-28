//
//  UIButton+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit

extension UIButton {
    func setAttributed(title: String, color: UIColor, font: UIFont?, isUnderLine: Bool = false ) {
        var attr = NSAttributedString()
        if isUnderLine {
            attr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font!, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        } else {
            attr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font!])
        }
        self.setAttributedTitle(attr, for: .normal)
    }
    
}
