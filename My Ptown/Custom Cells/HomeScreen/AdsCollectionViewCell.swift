//
//  AdsCollectionViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 28.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {
    //MARK: -Properties
    @IBOutlet weak var adsImageView: UIImageView!
    @IBOutlet weak var adsLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    //MARK: -Lifecycle
    override func awakeFromNib() {
        adsImageView.layer.cornerRadius = 10
        adsLabel.clipsToBounds = true
        gradientView.layer.cornerRadius = 10
        gradientView.fadeView(percentage: 0.7)
    }
    //MARK: -Helpers
    func setView(venue_description: String?, imageUrl: String?) {
        adsLabel.text = venue_description
        if let imageUrl = imageUrl {
            let url = URL(string: imageUrl)
            adsImageView.kf.setImage(with: url)
        }
    }
}
