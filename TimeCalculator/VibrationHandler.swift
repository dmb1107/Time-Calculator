//
//  VibrationHandler.swift
//  TimeCalculator
//
//  Created by Dave Becker on 10/24/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class VibrationHandler: UIFeedbackGenerator {
    let generator = UIImpactFeedbackGenerator(style: .light)
    func vibrate(){
        generator.impactOccurred()
    }
}
