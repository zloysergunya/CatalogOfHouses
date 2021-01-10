//
//  AuthDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 08.01.2021.
//

import RealmSwift

class AuthDataProvider {
    let realM = try! Realm()
    
    func signIn(user: String, password: String, completion: @escaping (_ status: Int) -> Void) {
        var params = ["action": "Auth"] as [String:Any]
        params["params"] = ["user": user, "pass": password].jsonString()
        NetworkManager(params: params) { data, status in
            if let json = (data?.json as? [String:Any])?["result"] as? [String:Any] {
                self.saveUser(json)
            }
            completion(status)
        }
    }
    
    private func saveUser(_ dict: [String:Any]) {
        try! realM.write {
            realM.add(User(dict), update: .modified)
        }
    }
}
