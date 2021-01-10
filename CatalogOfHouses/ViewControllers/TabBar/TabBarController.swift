//
//  TabBarController.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let mainVC = UINavigationController(rootViewController: MainVC(nibName: "MainVC", bundle: nil))
        mainVC.tabBarItem.title = "Главная"
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        
        let profileVC = UINavigationController(rootViewController: ProfileVC(nibName: "ProfileVC", bundle: nil))
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        let aboutAppVC = UINavigationController(rootViewController: AboutAppVC(nibName: "AboutAppVC", bundle: nil))
        aboutAppVC.tabBarItem.title = "Описание"
        aboutAppVC.tabBarItem.image = UIImage(systemName: "line.horizontal.3")
        
        tabBar.barTintColor = .blackMainColor
        tabBar.tintColor = .orangeMainColor
        tabBar.unselectedItemTintColor = .white
        tabBar.layer.cornerRadius = 15
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.alpha = 0.95
        
        viewControllers = [mainVC, profileVC, aboutAppVC]
        
        UINavigationBar.appearance().barTintColor = .blackMainColor
        UINavigationBar.appearance().isTranslucent = false
    }
}
