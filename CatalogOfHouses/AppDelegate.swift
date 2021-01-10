//
//  AppDelegate.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("======= Директория приложения =======\n\(NSHomeDirectory())\n=============================\n")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LaunchScreen(nibName: "LaunchScreen", bundle: nil)
        window?.makeKeyAndVisible()
        
        setupKeyboardManager()
        
        return true
    }
    
    private func setupKeyboardManager() {
        let manager = IQKeyboardManager.shared
        manager.enable = true
        manager.toolbarTintColor = .orangeMainColor
        manager.toolbarDoneBarButtonItemText = "Готово"
        manager.placeholderColor = .white
        manager.toolbarBarTintColor = .blackMainColor
    }
}
