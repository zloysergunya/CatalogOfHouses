//
//  UKVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit
import RealmSwift

class UKVC: UIViewController {
    @IBOutlet weak var ukTable: UITableView!
    @IBOutlet weak var totalSquareButton: RoundButton!
    @IBOutlet weak var cityNameButton: RoundButton!
    
    private let dataProvider = UKDataProvider()
    private var uks: Results<UK>!
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
        setupTableView(ukTable)
        setupNavigationBar()
        dataProvider.updateUK(cityID: cityID) { [weak self] status in
            guard let self = self else { return }
            if status > 399 {
                self.dialog(status)
            } else {
                self.updateUI()
            }
        }
        if let cityName = dataProvider.getCityName(cityID: cityID) {
            cityNameButton.setTitle("г. \(cityName)", for: .normal)
        }
    }
    
    private func setupNavigationBar() {
        setupMiddleNavigationImageView()
    }
    
    private func updateUI() {
        totalSquareButton.setTitle("\(dataProvider.getTotalUKSquare()) кв.м.", for: .normal)
        uks = dataProvider.getUK()
        ukTable.reloadData()
    }
}

// MARK: - work with tableView
extension UKVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.setupCell(name: uks[indexPath.row].ukName, totalSquare: uks[indexPath.row].totalSquare)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StreetsVC(nibName: "StreetsVC", bundle: nil)
        vc.cityID = cityID
        vc.ukID = uks[indexPath.row].ukID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
