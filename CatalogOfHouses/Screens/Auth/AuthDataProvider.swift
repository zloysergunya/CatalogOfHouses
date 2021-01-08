//
//  AuthDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 08.01.2021.
//

import Foundation

class AuthDataProvider {
    func signIn(user: String, password: String, complition: @escaping (_ status: Int) -> Void) {
        var params = ["action": "Auth"] as [String:Any]
        params["params"] = ["user": user, "pass": password].jsonString()
        HTTPRequest(params: params) { data, status in
            complition(status)
        }
    }
}
