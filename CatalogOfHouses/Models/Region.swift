//
//  Region.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 09.01.2021.
//

import RealmSwift

class Region: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "regionID"
    }
    @objc dynamic var regionID = String()
    @objc dynamic var regionName = String()
    @objc dynamic var totalHouse = Int()
    @objc dynamic var totalSquare = Double()
    
    enum CodingKeys: String, CodingKey {
        case regionID = "regionID"
        case regionName = "regionName"
        case totalHouse = "totalHouse"
        case totalSquare = "totalSquare"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        regionID = dictionary["regionID"] as! String
        regionName = dictionary["regionName"] as? String ?? "Нет данных"
        totalHouse = dictionary["totalHouse"] as? Int ?? 0
        totalSquare = dictionary["totalSquare"] as? Double ?? 0
    }
}

