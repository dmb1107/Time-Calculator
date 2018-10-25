//
//  GlobalVars.swift
//  TimeCalculator
//
//  Created by Dave Becker on 9/19/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import Foundation
import UIKit

struct styles {
    static let font = UIFont(name: "CourierNewPSMT", size: 17.0)
    static let headerFont = UIFont(name: "CourierNewPSMT", size: 30.0)
    static let header2Font = UIFont(name: "CourierNewPSMT", size: 26.0)
    static let labelFont = UIFont(name: "CourierNewPSMT", size: 24.0)
    static let calculatedFont = UIFont(name: "CourierNewPS-BoldMT", size: 36.0)
    static let infoViewBackgroundColor = UIColor(red:0.07, green:0.21, blue:0.36, alpha:1.0)
    static let topViewBackgroundColor = UIColor(red:0.00, green:0.13, blue:0.26, alpha:1.0)
    static let topViewBackgroundColorDimmed = UIColor(red:0.00, green:0.13, blue:0.26, alpha:0.3)
    static let lightLabelColor = UIColor.white
    static let middleViewBackgroundColor = UIColor(red:0.07, green:0.21, blue:0.36, alpha:1.0)
    static let bottomViewBackgroundColor = UIColor.white
    static let buttonBackgroundColor = UIColor(red:0.04, green:0.50, blue:1.00, alpha:1.0)
}
struct constants {
    static let screenSize = UIScreen.main.bounds
}

class VibrationHandler: UIFeedbackGenerator {
    let generator = UIImpactFeedbackGenerator(style: .light)
    func vibrate(){
        generator.impactOccurred()
    }
}
