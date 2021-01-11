//
//  MainCell.swift
//  CatalogOfHouses
//
//  Created by Sergey Kotov on 05.01.2021.
//

import UIKit

class MainCell: UITableViewCell {
    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var totalSquareLabel: UILabel!
    
    func setupCell(name: String, totalSquare: Double) {
        selectionStyle = .none
        regionNameLabel.text = name
        totalSquareLabel.text = "\(totalSquare) кв.м."
    }
    
}
