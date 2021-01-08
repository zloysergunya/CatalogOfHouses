//
//  MainVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var regionsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupUI() {
        setupTableView(regionsTable)
        setupNavigationBar()
//        let params = ["action": "GetRegions",
//                      "id": 4] as [String:Any]
//        HTTPRequest(params: params) { data, status in
//
//        }
        
        var params = ["action": "Auth"] as [String:Any]
        params["params"] = ["user":"test", "pass":""].jsonString()
        HTTPRequest(params: params) { data, status in
            
        }
    }
    
    private func setupNavigationBar() {
        let middleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 34, height: 38))
        middleImageView.image = UIImage(named: "logo")
        middleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = middleImageView
    }
    
    private func updateUI() {
        
    }

}

// MARK: - work with tableView
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.setupCell()
        return cell
    }
}
