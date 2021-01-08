//
//  AuthVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 08.01.2021.
//

import UIKit

class AuthVC: UIViewController {
    @IBOutlet weak var loginField: RoundField!
    @IBOutlet weak var passwordField: RoundField!
    
    private let dataProvider = AuthDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
    }

    @IBAction func signIn(_ sender: Any) {
        if loginField.text == "" {
            return
        }
//        if passwordField.text == "" {
//            return
//        }
        dataProvider.signIn(user: loginField.text!, password: passwordField.text!) { [weak self] status in
            guard let self = self else { return }
            if status > 399 {
                self.dialog(status)
            } else {
                self.checkPincode()
            }
        }
    }
    
    private func checkPincode() {
        let vc = TabBarController(nibName: "TabBarController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
