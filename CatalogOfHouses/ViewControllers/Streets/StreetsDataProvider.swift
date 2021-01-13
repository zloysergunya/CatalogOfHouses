//
//  StreetsDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 11.01.2021.
//

import RealmSwift

class StreetsDataProvider {
    let realM = try! Realm()
    
    func updateStreets(cityID: String, ukID: String = "", completion: @escaping (_ status: Int) -> Void) {
        var params = ["action": "GetStreets",
                      "id": USER.id] as [String: Any]
        params["params"] = ["versionApi": "1",
                            "cityID": cityID,
                            "ukID": ukID,
                            "filter": ["test": "123"]].jsonString()
        NetworkManager(params: params) { data, status in
            if let json = (data?.json as? [String:Any])?["result"] as? [String:Any],
               let data = json["data"] as? [[String:Any]] {
                data.forEach {
                    self.saveStreets($0)
                }
            }
            completion(status)
        }
    }
    
    private func saveStreets(_ dict: [String:Any]) {
        try! realM.write {
            realM.add(Street(dict), update: .modified)
        }
    }
    
    func getStreets() -> Results<Street> {
        return realM.objects(Street.self)
    }
    
    func getTotalStreetsSquare() -> Double {
        var square: Double = 0
        getStreets().forEach { street in
            square += street.totalSquare
        }
        return square
    }
    
    func getUKName(ukID: String) -> String? {
        realM.objects(UK.self).filter("ukID == %@", ukID).first?.ukName
    }
}
