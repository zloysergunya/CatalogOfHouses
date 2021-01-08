//
//  ProfileVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 06.01.2021.
//

import UIKit

class ProfileVC: UIViewController {

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
    }

    @IBAction func saveProfile(_ sender: Any) {
        
    }
}
