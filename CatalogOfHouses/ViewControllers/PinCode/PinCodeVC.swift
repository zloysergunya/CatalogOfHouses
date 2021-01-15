//
//  PinCodeVC.swift
//  DSoftMPI
//
//  Created by Sergey Kotov on 25.12.2020.
//

import UIKit
import LocalAuthentication

var PINCODE: String? {
    set { if let v = newValue { UserDefaults.standard.setValue(v, forKey: "pincode") }
          else { UserDefaults.standard.removeObject(forKey: "pincode") }}
    get { return UserDefaults.standard.string(forKey: "pincode") }
}

var isBiometricsEnabled: Bool {
    set { UserDefaults.standard.setValue(newValue, forKey: "isBiometricsEnabled") }
    get { return UserDefaults.standard.bool(forKey: "isBiometricsEnabled") }
}

var biometricsName: String? {
    set { if let v = newValue { UserDefaults.standard.setValue(v, forKey: "biometricsName") }
          else { UserDefaults.standard.removeObject(forKey: "biometricsName") }}
    get { return UserDefaults.standard.string(forKey: "biometricsName") }
}

class PinCodeVC: UIViewController {
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var changeUserButton: UIButton!
    @IBOutlet var pinCodeCircles: [UIImageView]!
    @IBOutlet weak var biometricButton: RoundButton!
    
    var localPinCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        fioLabel.text = USER.name
        localPinCode = ""
        setupBiometricButton()
    }
    
    private func setupBiometricButton() {
        if let isTouchIDAvailable = isTouchIDAvailable(), isBiometricsEnabled, PINCODE != nil {
            biometricButton.alpha = 1
            biometricButton.setImage(UIImage(systemName: isTouchIDAvailable ? "touchid" : "faceid"), for: .normal)
        } else {
            biometricButton.alpha = 0
        }
    }
    
    @IBAction func pinCodeEnter(_ sender: UIButton) {
        if pinCodeCircles.count > localPinCode.count {
            pinCodeCircles[localPinCode.count].setTintColor(.link)
            localPinCode += "\(sender.tag)"
            if localPinCode.count >= 4 {
                if let pincode = PINCODE {
                    if localPinCode == pincode {
                        setTabBar()
                    } else {
                        print("Неверно")
                        
                    }
                } else {
                    PINCODE = localPinCode
                    setTabBar()
                }
            }
        }
    }
    
    private func setTabBar() {
        let vc = TabBarController(nibName: "TabBarController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func changeUser(_ sender: Any) {
        AUTH_TOKEN = nil
        PINCODE = nil
        self.dismiss(animated: true)
        let vc = AuthVC(nibName: "AuthVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - work with biometric
extension PinCodeVC {
    func isTouchIDAvailable() -> Bool? {
        let laContext = LAContext()
        var error : NSError?
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let isTouchID = laContext.biometryType == .touchID
            biometricsName = isTouchID ? "Touch ID" : "Face ID"
            return isTouchID
        }
        return nil
    }
    
    @IBAction func callBiometriсScanner(_ sender: Any) {
        guard let biometric = isTouchIDAvailable() else { return }
        isBiometricsEnabled = true
        let laContext = LAContext()
        laContext.localizedFallbackTitle = "Ввести ПИН-код"
        laContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: biometric ? "Приложите палец" : "Посмотрите в камеру", reply: { success, error in
            if success {
                DispatchQueue.main.async {
                    self.setTabBar()
                }
            }
        })
    }
}
