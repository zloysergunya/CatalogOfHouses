//
//  UIViewController.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 08.01.2021.
//

import UIKit

extension UIViewController {
    func popAllViewControllers(animated: Bool, completion: (()->())?) {
        var count = 0
        if let c = self.navigationController?.viewControllers.count {
            count = c
        }
        if count > 1 {
            self.navigationController?.popViewController(animated: animated)
            if let handler = completion {
                handler()
            }
        } else {
            dismiss(animated: animated, completion: completion)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func dialog(_ error: Int = 0,
                text: (String, String)? = nil,
                onClose: ((UIAlertAction) -> Void)? = nil) {
        var t: (String, String)!
        if let text = text {
            t = text
        } else {
            switch error {
            case 401,403: t = ("Ошибка авторизации","Вы или кто-то другой сменили пароль к личному кабинету.")
            case 404: t = ("Нет информации","Для Вашей учетной записи нет данных для отображения.")
            case 500: t = ("Ошибка при получении данных","Мы уже работаем над этим.\nПожалуйста повторите попытку позднее.")
            default: t = ("Сервер недоступен","Возможно, идет обновление данных на сервере либо отсутствует доступ в Интернет. Проверьте интернет-соединение и повторите попытку.")
            }
        }
        let alert = UIAlertController(title: t.0, message: t.1, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.cancel, handler: onClose))
        self.present(alert, animated: true, completion: nil)
    }
    
    func dialog(title: String,
                message: String,
                default access: String? = nil,
                cancel: String? = "Закрыть",
                onAgree: ((UIAlertAction) -> Void)? = nil,
                onCancel: ((UIAlertAction) -> Void)? = nil) {
        if access?.isEmpty ?? true && cancel?.isEmpty ?? true { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let access = access {
            alert.addAction(UIAlertAction(title: access, style: .default, handler: onAgree))
        }
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: onCancel))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
