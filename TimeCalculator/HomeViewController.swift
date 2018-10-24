//
//  HomeViewController.swift
//  TimeCalculator
//
//  Created by Dave Becker on 9/19/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, setPickersToValuesDelegate {

    var hoursToAdd: Int = 0
    var minsToAdd: Int = 0
    let infoView = InfoView()
    let closeButton = CloseButton()
    let topHalfView = TopHalfView()
    let generator = VibrationHandler()
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = styles.bottomViewBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let timeToAddLabel: UILabel = {
        let label = UILabel()
        label.text = "Time To Add"
        label.font = styles.header2Font
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let hoursToAddLabel: UILabel = {
        let label = UILabel()
        label.text = "Hours"
        label.font = styles.labelFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let minsToAddLabel: UILabel = {
        let label = UILabel()
        label.text = "Minutes"
        label.font = styles.labelFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let hoursToAddPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tag = 1
        return picker
    }()
    let minsToAddPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tag = 2
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Time Calculator"
        topHalfView.delegate = self
        hoursToAddPicker.delegate = self
        hoursToAddPicker.dataSource = self
        minsToAddPicker.delegate = self
        minsToAddPicker.dataSource = self
        topHalfView.addTime(addHours: 0, addMins: 0)
        
        createInfoButton()
        let buttonStack = createCalculatorButtons()
        closeButton.addTarget(self, action: #selector(hideInfoView), for: .touchUpInside)
        closeButton.hide()
        infoView.hide()
        
        view.addSubview(topHalfView)
        view.addSubview(bottomView)
        view.addSubview(infoView)
        view.addSubview(closeButton)
        bottomView.addSubview(timeToAddLabel)
        bottomView.addSubview(hoursToAddLabel)
        bottomView.addSubview(minsToAddLabel)
        bottomView.addSubview(hoursToAddPicker)
        bottomView.addSubview(minsToAddPicker)
        bottomView.addSubview(buttonStack)
        
        constrainBottomView(stack: buttonStack)
        constrainInfoView()
        
    }
    
    func createInfoButton() {
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.setRightBarButton(barButton, animated: false)
    }
    
    func createCalculatorButtons() -> UIStackView {
        let fifteenMinButton = makeCalculatorButtonsWithText(text: "+15 Min")
        fifteenMinButton.tag = 15
        let thirtyMinButton = makeCalculatorButtonsWithText(text: "+30 Min")
        thirtyMinButton.tag = 30
        let fourtyFiveMinButton = makeCalculatorButtonsWithText(text: "+45 Min")
        fourtyFiveMinButton.tag = 45
        let oneHourButton = makeCalculatorButtonsWithText(text: "+1 Hr")
        oneHourButton.tag = 60
        let oneHourFifteenButton = makeCalculatorButtonsWithText(text: "+1 Hr 15 Min")
        oneHourFifteenButton.tag = 75
        let oneHourThirtyButton = makeCalculatorButtonsWithText(text: "+1 Hr 30 Min")
        oneHourThirtyButton.tag = 90
        
        return createButtonStack(array: [fifteenMinButton, thirtyMinButton, fourtyFiveMinButton, oneHourButton, oneHourFifteenButton, oneHourThirtyButton])
    }
    
    func makeCalculatorButtonsWithText(text: String) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle(text, for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.calculatorButtonClicked), for: .touchUpInside)
        return button
    }
    
    func createButtonStack(array: Array<UIButton>) -> UIStackView {
        let arrayTop: [UIButton] = Array(array[0...2])
        let arrayBottom: [UIButton] = Array(array[3...5])
        let stackHTop = UIStackView(arrangedSubviews: arrayTop)
        stackHTop.axis = .horizontal
        stackHTop.distribution = .fillEqually
        stackHTop.alignment = .fill
        stackHTop.spacing = 5
        stackHTop.translatesAutoresizingMaskIntoConstraints = false
        
        let StackHBottom = UIStackView(arrangedSubviews: arrayBottom)
        StackHBottom.axis = .horizontal
        StackHBottom.distribution = .fillEqually
        StackHBottom.alignment = .fill
        StackHBottom.spacing = 5
        StackHBottom.translatesAutoresizingMaskIntoConstraints = false
        
        let stackV = UIStackView(arrangedSubviews: [stackHTop, StackHBottom])
        stackV.axis = .vertical
        stackV.distribution = .fillEqually
        stackV.alignment = .fill
        stackV.spacing = 5
        stackV.layer.cornerRadius = 4
        stackV.translatesAutoresizingMaskIntoConstraints = false
        return stackV
    }
    
    
    func setPickersToValues(hours: Int, minutes: Int) {
        hoursToAddPicker.selectRow(hours, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(minutes, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: hours, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: minutes, inComponent: 0)
    }
    
    /*
     ------------------ Selector functions ------------------
     */
    
    @objc func infoButtonClicked(_ sender: UIBarButtonItem!){
        if infoView.isHidden() {
            showInfoView()
        } else {
            hideInfoView()
        }
    }
    
    func showInfoView() {
        infoView.show()
        closeButton.show()
        closeButton.frame = CGRect(x: infoView.frame.maxX-25, y: infoView.frame.minY-15, width: 40, height: 40)
        bottomView.isUserInteractionEnabled = false
        topHalfView.fadeOutAndDisableInteraction()
        UIView.animate(withDuration: 0.2) {
            self.infoView.alpha = 1.0
            self.closeButton.alpha = 1.0
            self.bottomView.alpha = 0.3
        }
    }
    
    @objc func hideInfoView() {
        infoView.hide()
        closeButton.hide()
        bottomView.isUserInteractionEnabled = true
        topHalfView.fadeInAndEnableInteraction()
        UIView.animate(withDuration: 0.2) {
            self.infoView.alpha = 0
            self.closeButton.alpha = 0
            self.bottomView.alpha = 1.0
            self.view.alpha = 1.0
        }
    }
    
    @objc func calculatorButtonClicked(_ sender: UIButton!) {
        generator.vibrate()
        let hours: Int = sender.tag / 60
        let minutes: Int = sender.tag % 60
        setPickersToValues(hours: hours, minutes: minutes)
    }

    
    /*
     ------------------ Picker functions ------------------
     */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return 12
        } else {
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format:"%i",row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            hoursToAdd = row
        } else {
            minsToAdd = row
        }
        topHalfView.addTime(addHours: hoursToAdd, addMins: minsToAdd)
    }
    
    /*
     ------------------ Constraints ------------------
     */
    
    func constrainInfoView() {
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        infoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }

    
    func constrainBottomView(stack: UIStackView) {
        topHalfView.translatesAutoresizingMaskIntoConstraints = false
        topHalfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topHalfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topHalfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topHalfView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: topHalfView.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        timeToAddLabel.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        timeToAddLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        timeToAddLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
        timeToAddLabel.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.175).isActive = true
        
        hoursToAddLabel.topAnchor.constraint(equalTo: timeToAddLabel.bottomAnchor).isActive = true
        hoursToAddLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive =  true
        hoursToAddLabel.widthAnchor.constraint(equalTo: minsToAddLabel.widthAnchor).isActive = true
        hoursToAddLabel.heightAnchor.constraint(equalTo: minsToAddLabel.heightAnchor).isActive = true
        
        minsToAddLabel.topAnchor.constraint(equalTo: timeToAddLabel.bottomAnchor).isActive = true
        minsToAddLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive =  true
        minsToAddLabel.widthAnchor.constraint(equalToConstant: minsToAddLabel.intrinsicContentSize.width).isActive = true
        minsToAddLabel.heightAnchor.constraint(equalTo: timeToAddLabel.heightAnchor, multiplier: 0.75).isActive = true
        
        hoursToAddPicker.topAnchor.constraint(equalTo: hoursToAddLabel.bottomAnchor).isActive = true
        hoursToAddPicker.leftAnchor.constraint(equalTo: hoursToAddLabel.leftAnchor).isActive = true
        hoursToAddPicker.rightAnchor.constraint(equalTo: hoursToAddLabel.rightAnchor).isActive = true
        hoursToAddPicker.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        minsToAddPicker.topAnchor.constraint(equalTo: minsToAddLabel.bottomAnchor).isActive = true
        minsToAddPicker.rightAnchor.constraint(equalTo: minsToAddLabel.rightAnchor).isActive = true
        minsToAddPicker.leftAnchor.constraint(equalTo: minsToAddLabel.leftAnchor).isActive = true
        minsToAddPicker.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        stack.topAnchor.constraint(equalTo: hoursToAddPicker.bottomAnchor, constant: 20).isActive = true
        if #available(iOS 11.0, *) {
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        } else {
            stack.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8).isActive = true
        }
        stack.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 8).isActive = true
        stack.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -8).isActive = true
    }
    
}
