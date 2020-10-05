//
//  TableViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 8.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryTableViewCell: UITableViewCell {
    //MARK: -Properties
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var totalRatingLabel: UILabel!
    @IBOutlet weak var venueRatingLabel: UILabel!
    @IBOutlet weak var venueVicinityLabel: UILabel!
    //MARK: -Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        venueImage.layer.cornerRadius = 10
        venueRatingLabel.layer.masksToBounds = true
        venueRatingLabel.layer.cornerRadius = 3
    }
    //MARK: -Helpers
    func setView(venueName: String?, rating: Double?, totalRating: Int?, icon: String?) {
        venueNameLabel.text = venueName
        if let rating = rating, let totalRating = totalRating, let icon = icon {
            venueRatingLabel.text = "\(rating)"
            venueRatingLabel.backgroundColor = setRatingLabelColorCell(rating: rating)
            totalRatingLabel.text = "\(totalRating) total ratings"
            let url = URL(string: icon)
            venueImage.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
        }
    }
    
    func setFavouritesView(venueName: String?, imageURL: String?, vicinity: String?, rating: Double?) {
        venueNameLabel.text = venueName
        venueVicinityLabel.text = vicinity
        
        if let rating = rating {
            venueRatingLabel.text = "\(rating)"
            venueRatingLabel.backgroundColor = setRatingLabelColorCell(rating: rating)
        }
        if let photoUrl = imageURL {
            let url = URL(string: "\(VENUE_IMAGEURL)\(photoUrl)" )
            venueImage.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
        }
    }
}
