//
//  CitiesDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 11.01.2021.
//

import RealmSwift

class UKDataProvider {
    let realM = try! Realm()
    
    func updateUK(cityID: String, completion: @escaping (_ status: Int) -> Void) {
        var params = ["action": "GetUK",
                      "id": USER.id] as [String: Any]
        params["params"] = ["versionApi": "1",
                            "cityID": cityID,
                            "filter": ["test": "123"]].jsonString()
        NetworkManager(params: params) { data, status in
            if let json = (data?.json as? [String:Any])?["result"] as? [String:Any],
               let data = json["data"] as? [[String:Any]] {
                data.forEach {
                    self.saveUK($0)
                }
            }
            completion(status)
        }
    }
    
    private func saveUK(_ dict: [String:Any]) {
        try! realM.write {
            realM.add(UK(dict), update: .modified)
        }
    }
    
    func getUK() -> Results<UK> {
        return realM.objects(UK.self)
    }
    
    func getTotalUKSquare() -> Double {
        var square: Double = 0
        getUK().forEach { uk in
            square += uk.totalSquare
        }
        return square
    }
    
    func getCityName(cityID: String) -> String? {
        realM.objects(City.self).filter("cityID == %@", cityID).first?.cityName
    }
}
