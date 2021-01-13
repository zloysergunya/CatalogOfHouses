//
//  MainVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit
import RealmSwift

class CitiesVC: UIViewController {
    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var totalSquareButton: RoundButton!
    
    private let dataProvider = CitiesDataProvider()
    private var cities: Results<City>!
    var regionID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupUI() {
        setupTableView(citiesTable)
        setupNavigationBar()
        dataProvider.updateCities(regionID: regionID) { [weak self] status in
            guard let self = self else { return }
            if status > 399 {
                self.dialog(status)
            } else {
                self.updateUI()
            }
        }
    }
    
    private func setupNavigationBar() {
        setupMiddleNavigationImageView()
    }
    
    private func updateUI() {
        totalSquareButton.setTitle("\(dataProvider.getTotalCitiesSquare()) кв.м.", for: .normal)
        cities = dataProvider.getCities()
        citiesTable.reloadData()
    }
}

// MARK: - work with tableView
extension CitiesVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.setupCell(name: cities[indexPath.row].cityName, totalSquare: cities[indexPath.row].totalSquare)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UKVC(nibName: "UKVC", bundle: nil)
        vc.cityID = cities[indexPath.row].cityID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
