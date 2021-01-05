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
        let mainVC = MainVC(nibName: "MainVC", bundle: nil)
        mainVC.tabBarItem.title = "Главная"
        mainVC.tabBarItem.image = UIImage.init(systemName: "square.grid.2x2")?.withTintColor(.white)
        mainVC.tabBarItem.selectedImage = UIImage.init(systemName: "square.grid.2x2")?.withTintColor(.yellow)
        
        let aboutAppVC = AboutAppVC(nibName: "AboutAppVC", bundle: nil)
        aboutAppVC.tabBarItem.title = "Описание"
        aboutAppVC.tabBarItem.image = UIImage.init(systemName: "line.horizontal.3")?.withTintColor(.white)
//        self.tabBar.barTintColor = UIColor(hex: "#707070")
//        self.tabBar.alpha = 0.5
        viewControllers = [mainVC, aboutAppVC]
    }

}
