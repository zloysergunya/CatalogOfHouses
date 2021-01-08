//
//  MainDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 08.01.2021.
//

import Foundation

class MainDataProvider {
    func getRegions(completion: @escaping (_ status: Int) -> Void) {
        var params = ["action": "GetRegions",
                      "id": 4] as [String: Any]
        params["params"] = ["versionApi": "1",
                            "filter": ["test": "123"].jsonString()].jsonString()
        NetworkManager(params: params) { data, status in
            completion(status)
        }
    }
}
