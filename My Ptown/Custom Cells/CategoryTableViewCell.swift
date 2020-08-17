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
            setRatingLabelColor(rating: rating)
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
            setRatingLabelColor(rating: rating)
        }
        if let photoUrl = imageURL {
            let url = URL(string: "\(VENUE_IMAGEURL)\(photoUrl)" )
            venueImage.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
        }
    }
    
    func setRatingLabelColor(rating: Double) {
        switch rating {
        case 4.5...5:
            venueRatingLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case 4...4.5:
                venueRatingLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 3...4:
                venueRatingLabel.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case 1...3:
                venueRatingLabel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        default:
             venueRatingLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
