//
//  SearchTableViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 23.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchNameLabel: UILabel!
    @IBOutlet weak var searchRatingLabel: UILabel!
    @IBOutlet weak var searchTotalRatingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchRatingLabel.layer.masksToBounds = true
        searchRatingLabel.layer.cornerRadius = 3
    }

    func setView(icon: String?, name: String?, rating: Double?, totalRating: Int?) {
        searchNameLabel.text = name
        if let totalRating = totalRating, let rating = rating {
            searchRatingLabel.text = String(rating)
            searchTotalRatingLabel.text = "\(totalRating) total ratings"
            searchRatingLabel.backgroundColor = setRatingLabelColorCell(rating: rating)
        }
    }
}
