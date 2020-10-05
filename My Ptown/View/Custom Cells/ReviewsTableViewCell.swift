//
//  ReviewsTableViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 24.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class ReviewsTableViewCell: UITableViewCell {
    //MARK: -Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var reviewRateLabel: UILabel!
    @IBOutlet weak var reviewProfilePhoto: UIImageView!
    //MARK: -Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: -Helpers
    func setReviews(time: String, author: String, comment: String, profile_photo_url: String, rate: Int) {
        self.timeLabel.text = time
        self.authorLabel.text = author
        self.reviewRateLabel.text = "\(rate)★"
        if comment != "" {
            commentLabel.text = comment
        } else {
            commentLabel.text = ""
        }
        let url = URL(string: profile_photo_url)
        reviewProfilePhoto.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
    }
}
