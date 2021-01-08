//
//  AppDelegate.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("======= Директория приложения =======\n\(NSHomeDirectory())\n=============================\n")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController(nibName: "TabBarController", bundle: nil)
        window?.makeKeyAndVisible()
        
        return true
    }
}
