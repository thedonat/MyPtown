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

    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueVicinityLabel: UILabel!
    @IBOutlet weak var venueRatingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        venueImage.layer.cornerRadius = 10
        venueRatingLabel.layer.cornerRadius = 10
    }
    
    
    func createPhotoUrl(from photoUrl: String) {
        let baseUrl = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=2000&photoreference=\(photoUrl)&key=AIzaSyATywHWyquPTWxl2IIt9eNSPdkl4YNBtHs"
        let url = URL(string: baseUrl)
        venueImage.kf.setImage(with: url, placeholder: UIImage(named: "unicorn"))
    }

    func setView(venueName: String, addressName: String, imageURL: String, rating: Double) {
        venueNameLabel.text = venueName
        venueVicinityLabel.text = addressName
        createPhotoUrl(from: imageURL)
        venueRatingLabel.text = "\(rating)"
        setRatingLabelColor(rating: rating)
    }
    
    func setRatingLabelColor(rating: Double) {
        switch rating {
        case 4...5:
            venueRatingLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case 3...4:
                venueRatingLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 1...3:
                venueRatingLabel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        default:
             venueRatingLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
