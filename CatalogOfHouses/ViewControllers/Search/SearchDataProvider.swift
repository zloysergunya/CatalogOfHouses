//
//  SearchDataProvider.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 11.01.2021.
//

import RealmSwift

class SearchDataProvider {
    let realM = try! Realm()
    
    func searchByText(_ searchText: String) {
        var params = ["action": "SearchByAddress",
                      "id": USER.id] as [String: Any]
        params["params"] = ["versionApi": "1",
                            "query": searchText].jsonString()
        NetworkManager(params: params) { data, status in
            if let json = (data?.json as? [String:Any])?["result"] as? [String:Any] {
                
            }
        }
    }
}
