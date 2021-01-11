//
//  LaunchScreen.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 09.01.2021.
//

import UIKit

class LaunchScreen: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAccount()
    }
    
    private func checkAccount() {
        if PINCODE != nil || AUTH_TOKEN != nil {
            print("AUTH_TOKEN: \(AUTH_TOKEN!)")
            let vc = PinCodeVC(nibName: "PinCodeVC", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            let vc = AuthVC(nibName: "AuthVC", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}
