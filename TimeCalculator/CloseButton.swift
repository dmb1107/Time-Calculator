//
//  CloseButton.swift
//  TimeCalculator
//
//  Created by Dave Becker on 10/4/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class CloseButton: UIButton {

    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createButton() {
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "closeButton.png"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFill
        button.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
    }
    
    func hide() {
        button.isHidden = true
    }
    
    func show() {
        button.isHidden = false
    }
    

}
