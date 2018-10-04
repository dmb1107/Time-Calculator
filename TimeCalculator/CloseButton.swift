//
//  CloseButton.swift
//  TimeCalculator
//
//  Created by Dave Becker on 10/4/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class CloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createButton() {
        layer.cornerRadius = 20
        setImage(UIImage(named: "closeButton.png"), for: .normal)
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageView?.contentMode = .scaleAspectFill
        autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
    }
    
    func hide() {
        isHidden = true
    }
    
    func show() {
        isHidden = false
    }
    

}
