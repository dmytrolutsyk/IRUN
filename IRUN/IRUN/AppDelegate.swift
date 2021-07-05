//
//  AppDelegate.swift
//  IRUN
//
//  Created by Dmytro LUTSYK on 25/05/2021.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (success, error) in
            
        }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: DevicesTableViewController())
        window.makeKeyAndVisible()
        
        self.window = window

        return true
    }

}



