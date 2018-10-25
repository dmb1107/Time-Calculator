//
//  TopHalfView.swift
//  TimeCalculator
//
//  Created by Dave Becker on 10/24/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class TopHalfView: UIView {
    
    let screenSize = UIScreen.main.bounds
    let topView = TopView()
    weak var delegate: setPickersToValuesDelegate?
    let middleView: UIView = {
        let view = UIView()
        view.backgroundColor = styles.middleViewBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let originalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Original Time"
        label.font = styles.headerFont
        label.textColor = styles.lightLabelColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let originalTimePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.date = NSDate() as Date
        picker.setValue(styles.lightLabelColor, forKeyPath: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return picker
    }()
    let setAsCurrentTimeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Set as current time", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = styles.buttonBackgroundColor.cgColor
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(currentTimeButtonClicked), for: .touchUpInside)
        return button
    }()
    let currentTimeButtonContainer = UIView()
    
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
        addSubview(topView)
        addSubview(middleView)
        currentTimeButtonContainer.addSubview(setAsCurrentTimeButton)
        middleView.addSubview(originalTimeLabel)
        middleView.addSubview(originalTimePicker)
        middleView.addSubview(currentTimeButtonContainer)
    }
    
    private func setupLayout() {
        constrainTopView()
        constrainMiddleView()
    }
    
    func addTime(isAdd: Bool, addHours: Int , addMins: Int) {
        var components = DateComponents()
        components.minute = isAdd ? addMins : -addMins
        components.hour = isAdd ? addHours : -addHours
        let originalDate = originalTimePicker.date
        let futureDate = Calendar.current.date(byAdding: components, to: originalDate)
        topView.setCalculatedLabelTextFromDate(date: futureDate!)
    }
    
    func fadeOutAndDisableInteraction() {
        topView.isUserInteractionEnabled = false
        middleView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.middleView.alpha = 0.3
            self.topView.setTopAlpha(alpha: 0.3)
        }
    }
    
    func fadeInAndEnableInteraction() {
        topView.isUserInteractionEnabled = true
        middleView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.2) {
            self.middleView.alpha = 1.0
            self.topView.setTopAlpha(alpha: 1.0)
        }
    }
    
    /*
     ------------------ Selector functions ------------------
     */
    
    @objc func currentTimeButtonClicked(_ sender: UIButton!){
        let date = Date()
        VibrationHandler().vibrate()
        setDatePickerValue(date: date)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        delegate?.setPickersToValues(hours: 0, minutes: 0)
    }
    
    func setDatePickerValue(date: Date) {
        originalTimePicker.date = date
        datePickerValueChanged(originalTimePicker)
    }
    
    /*
     ------------------ Constraints ------------------
     */
    
    private func constrainTopView() {
        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: (screenSize.height - 100) * 0.12).isActive = true
    }
    
    private func constrainMiddleView() {
        middleView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        middleView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        middleView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        middleView.heightAnchor.constraint(equalToConstant: (screenSize.height - 100) * 0.38-20).isActive = true
        
        originalTimeLabel.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        originalTimeLabel.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        originalTimeLabel.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        
        originalTimePicker.topAnchor.constraint(equalTo: originalTimeLabel.bottomAnchor).isActive = true
        originalTimePicker.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        originalTimePicker.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        originalTimePicker.centerYAnchor.constraint(equalTo: middleView.centerYAnchor).isActive = true
        originalTimePicker.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.45).isActive = true
        
        currentTimeButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        currentTimeButtonContainer.topAnchor.constraint(equalTo: originalTimePicker.bottomAnchor).isActive = true
        currentTimeButtonContainer.bottomAnchor.constraint(equalTo: middleView.bottomAnchor).isActive = true
        currentTimeButtonContainer.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        currentTimeButtonContainer.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        
        setAsCurrentTimeButton.centerXAnchor.constraint(equalTo: currentTimeButtonContainer.centerXAnchor).isActive = true
        setAsCurrentTimeButton.centerYAnchor.constraint(equalTo: currentTimeButtonContainer.centerYAnchor).isActive = true
        setAsCurrentTimeButton.widthAnchor.constraint(equalToConstant: setAsCurrentTimeButton.intrinsicContentSize.width + 20).isActive = true
        setAsCurrentTimeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}

protocol setPickersToValuesDelegate: class {
    func setPickersToValues(hours: Int, minutes: Int)
}
