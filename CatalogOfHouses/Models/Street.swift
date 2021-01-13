//
//  Street.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 13.01.2021.
//

import RealmSwift

class Street: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "streetID"
    }
    @objc dynamic var streetID = String()
    @objc dynamic var streetName = String()
    @objc dynamic var totalHouse = Int()
    @objc dynamic var totalSquare = Double()
    
    enum CodingKeys: String, CodingKey {
        case streetID = "streetID"
        case streetName = "streetName"
        case totalHouse = "totalHouse"
        case totalSquare = "totalSquare"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        streetID = dictionary["streetID"] as! String
        streetName = dictionary["streetName"] as? String ?? "Нет данных"
        totalHouse = dictionary["totalHouse"] as? Int ?? 0
        totalSquare = dictionary["totalSquare"] as? Double ?? 0
    }
}
