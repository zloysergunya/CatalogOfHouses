//
//  ProfileVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 06.01.2021.
//

import UIKit

var isSortingByUKEnabled: Bool {
    set { UserDefaults.standard.setValue(newValue, forKey: "isSortingByUKEnabled") }
    get { return UserDefaults.standard.bool(forKey: "isSortingByUKEnabled") }
}

class ProfileVC: UIViewController {
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var infoDateLabel: UILabel!
    @IBOutlet weak var biometricsSwitch: UISwitch!
    @IBOutlet weak var biometricsNameLabel: UILabel!
    @IBOutlet weak var sortingByUKSwitch: UISwitch!
    
    let dataProvider = ProfileDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        fioLabel.text = dataProvider.getUser().name
        biometricsSwitch.isOn = isBiometricsEnabled
        biometricsNameLabel.text = biometricsName ?? "Биометрическая аутентификация"
        sortingByUKSwitch.isOn = isSortingByUKEnabled
    }
    
    private func setupNavigationBar() {
        setupMiddleNavigationImageView()
    }

    @IBAction func saveProfile(_ sender: Any) {
        
    }
    
    @IBAction func switchBiometrics(_ sender: UISwitch) {
        isBiometricsEnabled = sender.isOn
    }
    
    @IBAction func switchSortingByUK(_ sender: UISwitch) {
        isSortingByUKEnabled = sender.isOn
    }
}
