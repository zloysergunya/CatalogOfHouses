//
//  CitiesDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 11.01.2021.
//

import RealmSwift

class CitiesDataProvider {
    let realM = try! Realm()
    
    func updateCities(regionID: String, completion: @escaping (_ status: Int) -> Void) {
        var params = ["action": "GetCities",
                      "id": USER.id] as [String: Any]
        params["params"] = ["versionApi": "1",
                            "regionID": regionID,
                            "filter": ["test": "123"]].jsonString()
        NetworkManager(params: params) { data, status in
            if let json = (data?.json as? [String:Any])?["result"] as? [String:Any],
               let data = json["data"] as? [[String:Any]] {
                data.forEach {
                    self.saveCities($0)
                }
            }
            completion(status)
        }
    }
    
    private func saveCities(_ dict: [String:Any]) {
        try! realM.write {
            realM.add(City(dict), update: .modified)
        }
    }
    
    func getCities() -> Results<City> {
        return realM.objects(City.self)
    }
    
    func getTotalCitiesSquare() -> Double {
        var square: Double = 0
        getCities().forEach { city in
            square += city.totalSquare
        }
        return square
    }
}
