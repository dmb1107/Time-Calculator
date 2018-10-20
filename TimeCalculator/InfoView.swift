//
//  InfoView.swift
//  TimeCalculator
//
//  Created by Dave Becker on 10/4/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
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
    let donateButton: UIButton = {
       let button = UIButton()
        button.setTitle("Donate $.99?", for: .normal)
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
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupView() {
        backgroundColor = styles.infoViewBackgroundColor
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(createdByLabel)
        addSubview(emailButton)
        addSubview(websiteButton)
        addSubview(donateButton)
        
    }
    
    func setupLayout() {
        createdByLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        createdByLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80).isActive = true
        createdByLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.9).isActive = true
        
        emailButton.topAnchor.constraint(equalTo: createdByLabel.bottomAnchor, constant: 60).isActive = true
        emailButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
        websiteButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 25).isActive = true
        websiteButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        websiteButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
        donateButton.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: 25).isActive = true
        donateButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        donateButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
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
            // TODO: in app purchase
        }
    }
    
}
