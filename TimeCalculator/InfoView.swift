//
//  InfoView.swift
//  TimeCalculator
//
//  Created by Dave Becker on 10/4/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit
import StoreKit

class InfoView: UIView{
    
    var stack = UIStackView()
    
    let createdByLabel: UILabel = {
        let label = UILabel()
        label.text = "Application developed by Dave Becker."
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Email me", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.tag = 0
        button.addTarget(self, action: #selector(InfoViewButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let websiteButton: UIButton = {
        let button = UIButton()
        button.setTitle("My website", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.tag = 1
        button.addTarget(self, action: #selector(InfoViewButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let reviewButton: UIButton = {
       let button = UIButton()
        button.setTitle("Submit a review", for: .normal)
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.tag = 2
        button.addTarget(self, action: #selector(InfoViewButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.spacing = self.bounds.width * 0.05
    }
    
    private func setupView() {
        backgroundColor = styles.infoViewBackgroundColor
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        translatesAutoresizingMaskIntoConstraints = false
        createStackView()
        addSubview(stack)
        setupLayout()
    }
    func createStackView() {
        stack = UIStackView(arrangedSubviews: [createdByLabel, emailButton, websiteButton, reviewButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayout() {
        stack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
    func isHidden() -> Bool{
        return self.isHidden
    }

    @objc func InfoViewButtonPressed(_ sender: UIButton!) {
        if sender.tag == 0 {
            let email = "becker.605@osu.edu"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 1 {
            if let url = URL(string: "http://dave-becker.com") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 2 {
            let appId = "id1439716657"
            if let url = URL(string: "itms-apps://itunes.apple.com/app/" + appId) {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
