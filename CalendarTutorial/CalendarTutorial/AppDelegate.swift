//
//  AppDelegate.swift
//  CalendarTutorial
//
//  Created by 이재용 on 2021/04/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = self.window {
            window.backgroundColor = UIColor.white
            let nav = UINavigationController()
            let mainView = UIStoryboard.init(name: "Calendar", bundle: nil).instantiateViewController(identifier: "ViewController")
            nav.viewControllers = [mainView]
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
        
        return true
    }

    
}

