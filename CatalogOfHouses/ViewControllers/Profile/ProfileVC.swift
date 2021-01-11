//
//  ProfileVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 06.01.2021.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var infoDateLabel: UILabel!
    
    let dataProvider = ProfileDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        fioLabel.text = dataProvider.getUser().name
    }
    
    private func setupNavigationBar() {
        setupMiddleNavigationImageView()
    }

    @IBAction func saveProfile(_ sender: Any) {
        
    }
}
