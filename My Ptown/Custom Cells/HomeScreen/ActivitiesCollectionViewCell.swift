//
//  ActivitiesCollectionViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 3.07.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class ActivitiesCollectionViewCell: UICollectionViewCell {
    //MARK: -Properties
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    //MARK: -Lifecycle
    override func awakeFromNib() {
        activityImageView.layer.cornerRadius = 10
        activityName.clipsToBounds = true
    }
    //MARK: -Helpers
    func setView(name: String?) {
        activityName.text = name
    }
}
