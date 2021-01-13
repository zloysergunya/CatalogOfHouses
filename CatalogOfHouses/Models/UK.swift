//
//  UK.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 13.01.2021.
//

import RealmSwift

class UK: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "ukID"
    }
    @objc dynamic var ukID = String()
    @objc dynamic var ukName = String()
    @objc dynamic var totalHouse = Int()
    @objc dynamic var totalSquare = Double()
    
    enum CodingKeys: String, CodingKey {
        case ukID = "ukID"
        case ukName = "ukName"
        case totalHouse = "totalHouse"
        case totalSquare = "totalSquare"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        ukID = dictionary["ukID"] as! String
        ukName = dictionary["ukName"] as? String ?? "Нет данных"
        totalHouse = dictionary["totalHouse"] as? Int ?? 0
        totalSquare = dictionary["totalSquare"] as? Double ?? 0
    }
}
