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
