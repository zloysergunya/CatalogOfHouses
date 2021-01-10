//
//  ProfileDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 09.01.2021.
//

import RealmSwift

class ProfileDataProvider {
    let realM = try! Realm()
    
    func getUser() -> User {
        realM.objects(User.self).first!
    }
}
