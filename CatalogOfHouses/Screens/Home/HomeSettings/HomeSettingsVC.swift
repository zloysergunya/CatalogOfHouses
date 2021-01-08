//
//  HomeSettingsVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 07.01.2021.
//

import UIKit

class HomeSettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let middleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 38))
        middleImageView.image = UIImage(named: "logo")
        middleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = middleImageView
        
//        let leftButton = UIButton(type: .system)
//        leftButton.addTarget(self, action: #selector(openHomeSettingsVC), for: .touchUpInside)
//        leftButton.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.white), for: .normal)
//        leftButton.tintColor = .white
//        leftButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.title = ""
    }

}
