//
//  User.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 09.01.2021.
//

import RealmSwift

class User: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id = String()
    @objc dynamic var name = String()
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        id = dictionary["id"] as! String
        name = dictionary["name"] as? String ?? "Нет данных"
    }
}

