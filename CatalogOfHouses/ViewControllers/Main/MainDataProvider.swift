//
//  MainDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 08.01.2021.
//

import RealmSwift

class MainDataProvider {
    let realM = try! Realm()
    
    func updateRegions(completion: @escaping (_ status: Int) -> Void) {
        var params = ["action": "GetRegions",
                      "id": 4] as [String: Any]
        params["params"] = ["versionApi": "1",
                            "filter": ["test": "123"]].jsonString()
        NetworkManager(params: params) { data, status in
            if let json = (data?.json as? [String:Any])?["result"] as? [String:Any],
               let data = json["data"] as? [[String:Any]] {
                data.forEach {
                    self.saveRegions($0)
                }
            }
            completion(status)
        }
    }
    
    private func saveRegions(_ dict: [String:Any]) {
        try! realM.write {
            realM.add(Region(dict), update: .modified)
        }
    }
    
    func getRegions() -> Results<Region> {
        return realM.objects(Region.self)
    }
    
    func getTotalRegionsSquare() -> Double {
        var square: Double = 0
        getRegions().forEach { region in
            square += region.totalSquare
        }
        return square
    }
    
    func deteleAll() {
        AUTH_TOKEN = nil
        PINCODE = nil
        try! realM.write {
            realM.deleteAll()
        }
    }
    
    
}
