//
//  City.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 11.01.2021.
//

import RealmSwift

class City: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "cityID"
    }
    @objc dynamic var cityID = String()
    @objc dynamic var cityName = String()
    @objc dynamic var totalHouse = Int()
    @objc dynamic var totalSquare = Double()
    
    enum CodingKeys: String, CodingKey {
        case cityID = "cityID"
        case cityName = "cityName"
        case totalHouse = "totalHouse"
        case totalSquare = "totalSquare"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        cityID = dictionary["cityID"] as! String
        cityName = dictionary["cityName"] as? String ?? "Нет данных"
        totalHouse = dictionary["totalHouse"] as? Int ?? 0
        totalSquare = dictionary["totalSquare"] as? Double ?? 0
    }
}
