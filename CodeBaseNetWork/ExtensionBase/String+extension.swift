//
//  String+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit

extension String {
    func isValidEmpty() -> Bool {
        if self.cutWhiteSpace().isEmpty {
            return true
        }
        return (self.cutWhiteSpace().trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "")
    }
    
    func cutWhiteSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isUrl() -> Bool {
        // create NSURL instance
        if let url = URL(string: self) {
            // check if your application can open the NSURL instance
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func toAttributedString(color: UIColor, font: UIFont, isUnderLine: Bool = false) -> NSAttributedString {
        if isUnderLine {
            return NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.underlineColor: color, NSAttributedStringKey.underlineStyle: 1])
        }
        return NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color])
    }
    
    func contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
