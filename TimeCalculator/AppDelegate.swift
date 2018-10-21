//
//  AppDelegate.swift
//  TimeCalculator
//
//  Created by Dave Becker on 9/19/18.
//  Copyright © 2018 Dave Becker Development. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let HomeVC = HomeViewController()
        let navVC = UINavigationController()
        navVC.viewControllers = [HomeVC]
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.tintColor = styles.topViewBackgroundColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: styles.topViewBackgroundColor]
        navVC.navigationBar.titleTextAttributes = textAttributes
        
        window?.rootViewController = navVC
        
        return true
    }

}

