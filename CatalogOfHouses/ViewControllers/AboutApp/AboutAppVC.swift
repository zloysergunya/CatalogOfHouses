//
//  AboutAppVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit

class AboutAppVC: UIViewController {
    @IBOutlet weak var aboutAppLabel: RoundLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        setupMiddleNavigationImageView()
    }
}
