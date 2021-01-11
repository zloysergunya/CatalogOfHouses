//
//  HomeVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 08.01.2021.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        setupMiddleNavigationImageView()
        
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
