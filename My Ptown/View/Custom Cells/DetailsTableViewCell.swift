//
//  DetailsTableViewCell.swift
//  My Ptown
//
//  Created by Burak Donat on 25.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
    
class DetailsTableViewCell: UITableViewCell {
    //MARK: -Properties
    @IBOutlet weak var favButton: UIButton!
    private var venuePhoneNumber = ""
    private var venueVicinity = ""
    var venueName = ""
    var venuePlaceID: String?
    var favoritePlaceIDs : [String] = []
    let defaults = UserDefaults.standard
    
    //MARK: -Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    //MARK: -Helpers
    @IBAction func callVenue(_ sender: UIButton) {
        createButtonAnimation(repeatCount: 1, button: sender)
        let urlSchema = "tel:"
        let numberToCall = venuePhoneNumber
        if numberToCall != ""{
            if let numberToCallURL = URL(string: "\(urlSchema)\("+1"+numberToCall)")
            {
                UIApplication.shared.open(numberToCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func getDirections(_ sender: UIButton) {
        createButtonAnimation(repeatCount: 1, button: sender)
        let urlSchema = "http://maps.apple.com/?q="
        let urlAdress = venueVicinity
        if let url = URL(string: "\(urlSchema)\(urlAdress)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        if let favouritedIDs = defaults.value(forKey: FAVPLACES) as? [String] {
               self.favoritePlaceIDs = favouritedIDs
           }
        if let favouriteVenueID = venuePlaceID {
            if !favoritePlaceIDs.contains(favouriteVenueID) {
                favoritePlaceIDs.append(favouriteVenueID)
                defaults.set(favoritePlaceIDs, forKey: FAVPLACES)
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                createButtonAnimation(repeatCount: 2, button: sender)
            } else {
                favoritePlaceIDs = favoritePlaceIDs.filter { $0 != favouriteVenueID }
                defaults.set(favoritePlaceIDs, forKey: FAVPLACES)
                favButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            }
        }
    }
    
    func setDetails(name: String?, phone_number: String?, vicinity: String?, placeID: String?) {
        if let name = name, let phone_number = phone_number, let vicinity = vicinity, let placeID = placeID {
            self.venuePhoneNumber = phone_number.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
            self.venueVicinity = vicinity.replacingOccurrences(of: " ", with: "+")
            self.venuePlaceID = placeID
            self.venueName = name
        }
        if let favouritedIDs = defaults.value(forKey: FAVPLACES) as? [String] {
            self.favoritePlaceIDs = favouritedIDs
        }
        if let favouriteVenueID = venuePlaceID {
            if !favoritePlaceIDs.contains(favouriteVenueID) {
                favButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            } else {
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
    func configureUI() {
        let dividerView1 = UIView()
        dividerView1.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.2039215686, blue: 0.431372549, alpha: 0.85)
        dividerView1.layer.cornerRadius = 75
        self.addSubview(dividerView1)
        dividerView1.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, height: 3)
    }
    
    func createButtonAnimation(repeatCount: Float, button: UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 1.0
        pulse.toValue = 1.2
        pulse.autoreverses = true
        pulse.repeatCount = repeatCount
        pulse.initialVelocity = 0.5
        pulse.damping = 0.8
        button.layer.add(pulse, forKey: nil)
    }
}

