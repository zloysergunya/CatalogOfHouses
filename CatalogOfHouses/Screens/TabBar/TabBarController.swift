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
//        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let middleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 38))
        middleImageView.image = UIImage(named: "logo")
        middleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = middleImageView
        
        let rightButton = UIButton(type: .system)
        rightButton.addTarget(self, action: #selector(openHomeSettingsVC), for: .touchUpInside)
        rightButton.setImage(UIImage(systemName: "ellipsis")?.withTintColor(.white), for: .normal)
        rightButton.tintColor = .white
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }

    @objc private func openHomeSettingsVC() {
        let vc = HomeSettingsVC(nibName: "HomeSettingsVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
