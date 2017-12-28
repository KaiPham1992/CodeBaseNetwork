//
//  KBaseViewXib.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit

class KBaseViewXib: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        view.fillSuperview()
        
        //---
        setUpViews()
    }
    
    func setUpViews() {
        
    }
    
}
