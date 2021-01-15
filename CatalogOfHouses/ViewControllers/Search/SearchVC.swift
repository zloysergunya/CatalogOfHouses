//
//  SearchVC.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 11.01.2021.
//

import UIKit
import IQKeyboardManagerSwift

class SearchVC: UIViewController {
    @IBOutlet weak var searchBar: RoundField!
    @IBOutlet weak var searchTable: UITableView!
    
    private let dataProvider = SearchDataProvider()
    private var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView(searchTable)
        IQKeyboardManager.shared.enable = false
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        setupMiddleNavigationImageView()
    }
}

// MARK: - work with tableView
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        return cell
    }
}

// MARK: - work with textField for search
extension SearchVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        dataProvider.searchByText(searchText)
        searchTable.reloadData()
        return true
    }
}
