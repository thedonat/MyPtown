//
//  NewsTableViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 13.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setView(title: String?, description: String?, source: String?, imageUrl: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        sourceLabel.text = source
        if let url = imageUrl {
            let url = URL(string: url)
            newsImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
        }
    }
}
