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
        mainVC.tabBarItem = UITabBarItem.init(title: "Главная", image: UIImage.init(systemName: "square.grid.2x2"), tag: 0)
        tabBarController?.tabBar.barTintColor = .blue
        viewControllers = [mainVC]
    }

}
