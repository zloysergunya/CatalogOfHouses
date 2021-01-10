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
    
    func setupCell(with region: Region) {
        selectionStyle = .none
        regionNameLabel.text = region.regionName
        totalSquareLabel.text = "\(region.totalSquare) кв.м."
    }
    
}
