//
//  HomeViewController.swift
//  TimeCalculator
//
//  Created by Dave Becker on 9/19/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
    let calculatedLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00 AM"
        label.font = styles.calculatedFont
        label.textAlignment = .center
        label.textColor = styles.lightLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
    let fifteenMinButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("+15 Min", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let thirtyMinButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("+30 Min", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let fourtyFiveMinButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("+45 Min", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let oneHourButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("+1 Hr", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let oneHourFifteenButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("+1 Hr 15 Min", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let oneHourThirtyButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("+1 Hr 30 Min", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButton = UIBarButtonItem(image: UIImage(named: "info.png"), style: .plain, target: self, action: #selector(infoButtonClicked))
        self.navigationItem.setRightBarButton(barButton, animated: false)
        
        self.view.backgroundColor = styles.topViewBackgroundColor
        self.title = "Time Calculator"
        let buttonArray = [fifteenMinButton, thirtyMinButton, fourtyFiveMinButton, oneHourButton, oneHourFifteenButton, oneHourThirtyButton]
        hoursToAddPicker.delegate = self
        hoursToAddPicker.dataSource = self
        minsToAddPicker.delegate = self
        minsToAddPicker.dataSource = self
        view.addSubview(calculatedLabel)
        constrainCalculatedLabel()
        updateCalculatedTime(addHours: 0, addMins: 0)
        view.addSubview(middleView)
        middleView.addSubview(originalTimeLabel)
        middleView.addSubview(originalTimePicker)
        middleView.addSubview(setAsCurrentTimeButton)
        setAsCurrentTimeButton.addTarget(self, action: #selector(self.currentTimeButtonClicked), for: .touchUpInside)
        constrainMiddleView()
        view.addSubview(bottomView)
        fifteenMinButton.addTarget(self, action: #selector(self.fifteenMinButtonClicked), for: .touchUpInside)
        thirtyMinButton.addTarget(self, action: #selector(self.thirtyMinButtonClicked), for: .touchUpInside)
        fourtyFiveMinButton.addTarget(self, action: #selector(self.fourtyFiveMinButtonClicked), for: .touchUpInside)
        oneHourButton.addTarget(self, action: #selector(self.oneHourButtonClicked), for: .touchUpInside)
        oneHourFifteenButton.addTarget(self, action: #selector(self.oneHourFifteenButtonClicked), for: .touchUpInside)
        oneHourThirtyButton.addTarget(self, action: #selector(self.oneHourThirtyButtonClicked), for: .touchUpInside)
        let buttonStack = createButtonStack(array: buttonArray)
        bottomView.addSubview(timeToAddLabel)
        bottomView.addSubview(hoursToAddLabel)
        bottomView.addSubview(minsToAddLabel)
        bottomView.addSubview(hoursToAddPicker)
        bottomView.addSubview(minsToAddPicker)
        bottomView.addSubview(buttonStack)
        constrainBottomView(stack: buttonStack)
        
        createInfoPage()
        view.addSubview(infoView)
        infoView.isHidden = true

        constrainInfoView()
        
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
        infoView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: -60).isActive = true
        
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
        emailButton.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        
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
        websiteButton.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
    }
    
    func constrainInfoView(){
        infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func constrainCalculatedLabel(){
        calculatedLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        calculatedLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        calculatedLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        calculatedLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func constrainMiddleView(){
        middleView.topAnchor.constraint(equalTo: calculatedLabel.bottomAnchor).isActive = true
        middleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        middleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        middleView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        originalTimeLabel.topAnchor.constraint(equalTo: calculatedLabel.bottomAnchor).isActive = true
        originalTimeLabel.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        originalTimeLabel.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        originalTimeLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        originalTimePicker.topAnchor.constraint(equalTo: originalTimeLabel.bottomAnchor).isActive = true
        originalTimePicker.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        originalTimePicker.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        originalTimePicker.bottomAnchor.constraint(equalTo: setAsCurrentTimeButton.topAnchor).isActive = true
        setAsCurrentTimeButton.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        setAsCurrentTimeButton.bottomAnchor.constraint(equalTo: middleView.bottomAnchor, constant: -10).isActive = true
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
        timeToAddLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        hoursToAddLabel.topAnchor.constraint(equalTo: timeToAddLabel.bottomAnchor).isActive = true
        hoursToAddLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive =  true
        hoursToAddLabel.widthAnchor.constraint(equalTo: minsToAddLabel.widthAnchor).isActive = true
        hoursToAddLabel.heightAnchor.constraint(equalTo: minsToAddLabel.heightAnchor).isActive = true
        
        minsToAddLabel.topAnchor.constraint(equalTo: timeToAddLabel.bottomAnchor).isActive = true
        minsToAddLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive =  true
        minsToAddLabel.widthAnchor.constraint(equalToConstant: minsToAddLabel.intrinsicContentSize.width).isActive = true
        minsToAddLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        hoursToAddPicker.topAnchor.constraint(equalTo: hoursToAddLabel.bottomAnchor).isActive = true
        hoursToAddPicker.leftAnchor.constraint(equalTo: hoursToAddLabel.leftAnchor).isActive = true
        hoursToAddPicker.rightAnchor.constraint(equalTo: hoursToAddLabel.rightAnchor).isActive = true
        hoursToAddPicker.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        minsToAddPicker.topAnchor.constraint(equalTo: minsToAddLabel.bottomAnchor).isActive = true
        minsToAddPicker.rightAnchor.constraint(equalTo: minsToAddLabel.rightAnchor).isActive = true
        minsToAddPicker.leftAnchor.constraint(equalTo: minsToAddLabel.leftAnchor).isActive = true
        minsToAddPicker.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        stack.topAnchor.constraint(equalTo: hoursToAddPicker.bottomAnchor, constant: 20).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5).isActive = true
        stack.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 5).isActive = true
        stack.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -5).isActive = true
        
    }
    
    @objc func infoButtonClicked(_ sender: UIBarButtonItem!){
        infoView.isHidden = !infoView.isHidden
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
        originalTimePicker.date = date
        hoursToAddPicker.selectRow(0, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 0, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 0, inComponent: 0)
    }
    
    @objc func  fifteenMinButtonClicked(_ sender: UIButton!){
        hoursToAddPicker.selectRow(0, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(15, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 0, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 15, inComponent: 0)
    }
    
    @objc func  thirtyMinButtonClicked(_ sender: UIButton!){
        hoursToAddPicker.selectRow(0, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(30, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 0, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 30, inComponent: 0)
    }
    
    @objc func  fourtyFiveMinButtonClicked(_ sender: UIButton!){
        hoursToAddPicker.selectRow(0, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(45, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 0, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 45, inComponent: 0)
    }
    
    @objc func  oneHourButtonClicked(_ sender: UIButton!){
        hoursToAddPicker.selectRow(1, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 1, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 0, inComponent: 0)
    }
    
    @objc func  oneHourFifteenButtonClicked(_ sender: UIButton!){
        hoursToAddPicker.selectRow(1, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(15, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 1, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 15, inComponent: 0)
    }
    
    @objc func  oneHourThirtyButtonClicked(_ sender: UIButton!){
        hoursToAddPicker.selectRow(1, inComponent: 0, animated: true)
        minsToAddPicker.selectRow(30, inComponent: 0, animated: true)
        self.pickerView(self.hoursToAddPicker, didSelectRow: 1, inComponent: 0)
        self.pickerView(self.minsToAddPicker, didSelectRow: 30, inComponent: 0)
    }
    
    
    func displayCalculatedTime(date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        calculatedLabel.text = dateFormatter.string(from: date)
    }
    
    func updateCalculatedTime(addHours: Int , addMins: Int){
        var components = DateComponents()
        components.minute = addMins
        components.hour = addHours
        let originalDate = originalTimePicker.date
        let futureDate = Calendar.current.date(byAdding: components, to: originalDate)
        displayCalculatedTime(date: futureDate!)
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
