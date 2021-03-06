//
//  TopView.swift
//  TimeCalculator
//
//  Created by Dave Becker on 10/3/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class TopView: UIView {

    lazy var calculatedLabel: UILabel = {
        let label = UILabel()
        label.font = styles.calculatedFont
        label.textAlignment = .center
        label.textColor = styles.lightLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00 AM"
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = styles.topViewBackgroundColor
        addSubview(calculatedLabel)
        setupLayout()
    }
    
    func setupLayout() {
        calculatedLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        calculatedLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        calculatedLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        calculatedLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        calculatedLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func setTopAlpha(alpha: CGFloat) {
        self.alpha = alpha
    }
    
    func setCalculatedLabelTextFromDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        calculatedLabel.text = dateFormatter.string(from: date)
    }
    
}
