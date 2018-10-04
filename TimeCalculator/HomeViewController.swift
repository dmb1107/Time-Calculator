//
//  HomeViewController.swift
//  TimeCalculator
//
//  Created by Dave Becker on 9/19/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let generator = UIImpactFeedbackGenerator(style: .light)
    var hoursToAdd: Int = 0
    var minsToAdd: Int = 0
    let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = styles.infoViewBackgroundColor
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 20
        btn.setImage(UIImage(named: "closeButton.png"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(hideInfoView), for: .touchUpInside)
        btn.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
        return btn
    }()
    let topView = TopView()
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
        return button
    }()
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
        hoursToAddPicker.delegate = self
        hoursToAddPicker.dataSource = self
        minsToAddPicker.delegate = self
        minsToAddPicker.dataSource = self
        createInfoButton()
        view.addSubview(topView)
        constrainTopView()
        updateCalculatedTime(addHours: 0, addMins: 0)
        view.addSubview(middleView)
        middleView.addSubview(originalTimeLabel)
        middleView.addSubview(originalTimePicker)
        middleView.addSubview(setAsCurrentTimeButton)
        setAsCurrentTimeButton.addTarget(self, action: #selector(self.currentTimeButtonClicked), for: .touchUpInside)
        constrainMiddleView()
        view.addSubview(bottomView)
        let buttonStack = createCalculatorButtons()
        bottomView.addSubview(timeToAddLabel)
        bottomView.addSubview(hoursToAddLabel)
        bottomView.addSubview(minsToAddLabel)
        bottomView.addSubview(hoursToAddPicker)
        bottomView.addSubview(minsToAddPicker)
        bottomView.addSubview(buttonStack)
        constrainBottomView(stack: buttonStack)
        
        createInfoPage()
        view.addSubview(infoView)
        view.addSubview(closeButton)
        closeButton.isHidden = true
        infoView.isHidden = true

        constrainInfoView()
        
    }
    
    func constrainTopView() {
        topView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true
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
    
    func createInfoPage(){
        let label = UILabel()
        label.text = "Application developed by Dave Becker."
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        infoView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: -60).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualTo: infoView.widthAnchor, multiplier: 0.9).isActive = true
        
        let emailButton = UIButton()
        emailButton.setTitle("Email me", for: .normal)
        emailButton.backgroundColor = styles.buttonBackgroundColor
        emailButton.setTitleColor(.white, for: .normal)
        emailButton.layer.cornerRadius = 5
        emailButton.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
        infoView.addSubview(emailButton)
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        emailButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60).isActive = true
        emailButton.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        emailButton.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 0.9).isActive = true
        
        let websiteButton = UIButton()
        websiteButton.setTitle("My website", for: .normal)
        websiteButton.backgroundColor = styles.buttonBackgroundColor
        websiteButton.setTitleColor(.white, for: .normal)
        websiteButton.layer.cornerRadius = 5
        websiteButton.addTarget(self, action: #selector(websiteButtonPressed), for: .touchUpInside)
        infoView.addSubview(websiteButton)
        websiteButton.translatesAutoresizingMaskIntoConstraints = false
        websiteButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 25).isActive = true
        websiteButton.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        websiteButton.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func constrainInfoView(){
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        infoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
//    func constrainCalculatedLabel(){
//        calculatedLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        calculatedLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        calculatedLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        calculatedLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true
//    }
    
    func constrainMiddleView(){
        middleView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        middleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        middleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        middleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.38).isActive = true
        originalTimeLabel.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        originalTimeLabel.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        originalTimeLabel.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        originalTimeLabel.heightAnchor.constraint(equalTo: originalTimePicker.heightAnchor, multiplier: 0.8).isActive = true
        originalTimePicker.topAnchor.constraint(equalTo: originalTimeLabel.bottomAnchor).isActive = true
        originalTimePicker.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        originalTimePicker.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        originalTimePicker.centerYAnchor.constraint(equalTo: middleView.centerYAnchor).isActive = true
        setAsCurrentTimeButton.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        setAsCurrentTimeButton.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -12).isActive = true
        setAsCurrentTimeButton.widthAnchor.constraint(equalToConstant: setAsCurrentTimeButton.intrinsicContentSize.width + 20).isActive = true
        setAsCurrentTimeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    func constrainBottomView(stack: UIStackView){
        bottomView.topAnchor.constraint(equalTo: middleView.bottomAnchor).isActive = true
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
    
    @objc func infoButtonClicked(_ sender: UIBarButtonItem!){
        if infoView.isHidden {
            showInfoView()
        } else {
            hideInfoView()
        }
    }
    
    func showInfoView() {
        infoView.isHidden = false
        closeButton.isHidden = false
        closeButton.frame = CGRect(x: infoView.frame.maxX-25, y: infoView.frame.minY-15, width: 40, height: 40)
        bottomView.isUserInteractionEnabled = false
        middleView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.infoView.alpha = 1.0
            self.closeButton.alpha = 1.0
            self.middleView.alpha = 0.3
            self.bottomView.alpha = 0.3
            self.view.backgroundColor = styles.topViewBackgroundColorDimmed
            self.topView.setCalculatedLabelAlpha(alpha: 0.3)
        }
    }
    
    @objc func hideInfoView() {
        infoView.isHidden = true
        closeButton.isHidden = true
        bottomView.isUserInteractionEnabled = true
        middleView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.2) {
            self.infoView.alpha = 0
            self.closeButton.alpha = 0
            self.middleView.alpha = 1.0
            self.bottomView.alpha = 1.0
            self.view.alpha = 1.0
            self.view.backgroundColor = styles.topViewBackgroundColor
            self.topView.setCalculatedLabelAlpha(alpha: 1.0)
        }
    }
    
    @objc func emailButtonPressed(_ sender: UIButton!){
        let email = "becker.605@osu.edu"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func websiteButtonPressed(_ sender: UIButton!){
        if let url = URL(string: "http://dave-becker.com") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func currentTimeButtonClicked(_ sender: UIButton!){
        let date = Date()
        generator.impactOccurred()
        originalTimePicker.date = date
        hoursToAddPicker.selectRow(0, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 0, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 0, inComponent: 0)
    }
    
    @objc func calculatorButtonClicked(_ sender: UIButton!) {
        generator.impactOccurred()
        let hours: Int = sender.tag / 60
        let minutes: Int = sender.tag % 60
        hoursToAddPicker.selectRow(hours, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(minutes, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: hours, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: minutes, inComponent: 0)
    }
    
    func updateCalculatedTime(addHours: Int , addMins: Int){
        var components = DateComponents()
        components.minute = addMins
        components.hour = addHours
        let originalDate = originalTimePicker.date
        let futureDate = Calendar.current.date(byAdding: components, to: originalDate)
        topView.setCalculatedLabelTextFromDate(date: futureDate!)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        hoursToAddPicker.selectRow(0, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 0, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 0, inComponent: 0)
    }
    
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
        updateCalculatedTime(addHours: hoursToAdd, addMins: minsToAdd)
    }

}
