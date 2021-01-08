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
        mainVC.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        
        let homeVC = UINavigationController(rootViewController: HomeVC(nibName: "HomeVC", bundle: nil))
        homeVC.tabBarItem.title = "Дом"
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        
        let profileVC = UINavigationController(rootViewController: ProfileVC(nibName: "ProfileVC", bundle: nil))
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        let aboutAppVC = UINavigationController(rootViewController: AboutAppVC(nibName: "AboutAppVC", bundle: nil))
        aboutAppVC.tabBarItem.title = "Описание"
        aboutAppVC.tabBarItem.image = UIImage(systemName: "line.horizontal.3")
        tabBar.barTintColor = UIColor(named: "blackMainColor")
        
        UINavigationBar.appearance().barTintColor = UIColor(named: "blackMainColor")
        UINavigationBar.appearance().isTranslucent = false
        
        viewControllers = [mainVC, homeVC, profileVC, aboutAppVC]
    }
}
