//
//  MainVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit
import RealmSwift

class MainVC: UIViewController {
    @IBOutlet weak var regionsTable: UITableView!
    @IBOutlet weak var totalSquareButton: RoundButton!
    @IBOutlet weak var searchBar: RoundField!
    
    private let dataProvider = MainDataProvider()
    private var regions: Results<Region>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupUI() {
        searchBar.delegate = self
        setupTableView(regionsTable)
        setupNavigationBar()
        dataProvider.updateRegions() { [weak self] status in
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
        
        let leftButton = UIButton(type: .system)
        leftButton.addTarget(self, action: #selector(exitToAuth), for: .touchUpInside)
        leftButton.setTitle("Выйти", for: .normal)
        leftButton.setTitleColor(.white, for: .normal)
        leftButton.tintColor = .white
        leftButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    
    private func updateUI() {
        totalSquareButton.setTitle("\(dataProvider.getTotalRegionsSquare()) кв.м.", for: .normal)
        regions = dataProvider.getRegions()
        regionsTable.reloadData()
    }
    
    @objc private func exitToAuth() {
        dialog(title: "Внимание", message: "Вы уверены, что хотите выйти?", default: "Да", cancel: "Нет", onAgree: { _ in
            self.dataProvider.deteleAll()
            self.popAllViewControllers(animated: true, completion: nil)
            self.view.window!.rootViewController?.dismiss(animated: false)
        })
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
        return regions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.setupCell(name: regions[indexPath.row].regionName, totalSquare: regions[indexPath.row].totalSquare)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CitiesVC(nibName: "CitiesVC", bundle: nil)
        vc.regionID = regions[indexPath.row].regionID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - work with textField
extension MainVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchBar {
            searchBar.endEditing(false)
            let vc = SearchVC(nibName: "SearchVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
