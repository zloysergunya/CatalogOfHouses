//
//  StreetsVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit
import RealmSwift

class StreetsVC: UIViewController {
    @IBOutlet weak var streetTable: UITableView!
    @IBOutlet weak var totalSquareButton: RoundButton!
    @IBOutlet weak var ukNameButton: RoundButton!
    
    private let dataProvider = StreetsDataProvider()
    private var streets: Results<Street>!
    var ukID = ""
    var cityID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupUI() {
        setupTableView(streetTable)
        setupNavigationBar()
        dataProvider.updateStreets(cityID: cityID, ukID: ukID) { [weak self] status in
            guard let self = self else { return }
            if status > 399 {
                self.dialog(status)
            } else {
                self.updateUI()
            }
        }
        if let ukName = dataProvider.getUKName(ukID: ukID) {
            ukNameButton.setTitle("УК - \(ukName)", for: .normal)
        }
    }
    
    private func setupNavigationBar() {
        setupMiddleNavigationImageView()
    }
    
    private func updateUI() {
        totalSquareButton.setTitle("\(dataProvider.getTotalStreetsSquare()) кв.м.", for: .normal)
        streets = dataProvider.getStreets()
        streetTable.reloadData()
    }
}

// MARK: - work with tableView
extension StreetsVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.setupCell(name: streets[indexPath.row].streetName, totalSquare: streets[indexPath.row].totalSquare)
        return cell
    }
}
