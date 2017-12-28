//
//  KBaseTableCellXib.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//
import UIKit

class KBaseTableCellXib: UITableViewCell {
    let lineBottom: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        lineView.isHidden = true
        
        return lineView
    }()
    
    func setUpViews() {
        selectionStyle = .none
        clipsToBounds = true
        backgroundColor = .clear
        addSubview(lineBottom)
        lineBottom.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    //-- XIB
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }
}
