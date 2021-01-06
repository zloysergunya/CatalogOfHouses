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
        setupNavigationBar()
        let mainVC = MainVC(nibName: "MainVC", bundle: nil)
        mainVC.tabBarItem.title = "Главная"
        mainVC.tabBarItem.image = UIImage.init(systemName: "square.grid.2x2")?.withTintColor(.white)
        mainVC.tabBarItem.selectedImage = UIImage.init(systemName: "square.grid.2x2")?.withTintColor(.yellow)
        
        let aboutAppVC = AboutAppVC(nibName: "AboutAppVC", bundle: nil)
        aboutAppVC.tabBarItem.title = "Описание"
        aboutAppVC.tabBarItem.image = UIImage.init(systemName: "line.horizontal.3")?.withTintColor(.white)
        self.tabBar.barTintColor = UIColor(named: "blackMainColor")
//        self.tabBar.alpha = 0.9
        viewControllers = [mainVC, aboutAppVC]
    }
    
    private func setupNavigationBar() {
        let leftButton = UIButton(type: .system)
        leftButton.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.white), for: .normal)
        leftButton.tintColor = .white
        leftButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let middleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 38))
        middleImageView.image = UIImage(named: "logo")
        middleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = middleImageView
        
        let rightButton = UIButton(type: .system)
        rightButton.setImage(UIImage(systemName: "ellipsis")?.withTintColor(.white), for: .normal)
        rightButton.tintColor = .white
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        UINavigationBar.appearance().barTintColor = UIColor(named: "blackMainColor")
        UINavigationBar.appearance().isTranslucent = false
    }

}
