//
//  AppDelegate.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 24/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBarApparence()
        return true
    }

    private func setupNavigationBarApparence(){
        UINavigationBar.appearance().backgroundColor = UIColor(red: 79 / 255, green: 206 / 255, blue: 173 / 255, alpha: 0.85)
    }
    
}

