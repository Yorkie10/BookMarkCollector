//
//  AppDelegate.swift
//  BookMarkCollector
//
//  Created by Yerkebulan Sharipov on 21.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
  
        if Storage.linkModels.isEmpty{
            
            window?.rootViewController = UINavigationController(rootViewController: ViewController())

        } else {
            window?.rootViewController = UINavigationController(rootViewController: SecondScreen())
        }
        return true
    }

}

