//
//  HomeCollectionViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 28.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    //MARK: -Properties
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    //MARK: -Lifecycle
    override func awakeFromNib() {
        menuImageView.layer.cornerRadius = 10
        menuImageView.clipsToBounds = true
        menuImageView.layer.opacity = 0.9
        gradientView.fadeView(percentage: 0.7)
        gradientView.layer.cornerRadius = 10
    }
    //MARK: -Helpers
    func setView(menu: String?, menuUrl: String?) {
        menuLabel.text = menu
        if let menuUrl = menuUrl {
            let url = URL(string: menuUrl)
            menuImageView.kf.setImage(with: url)
        }
    }
}
