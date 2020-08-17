//
//  VenueViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 22.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol VenueViewModelProtocol: class {
    func didGetVenueData()
}

class VenueViewModel {
    weak var delegate: VenueViewModelProtocol?
    var venue : VenueResult?
    var getPlaceId: String?
    
    init(venue: VenueResult? = nil) {
        self.venue = venue
    }
    
    func getVenueDetails() {
        if let placeID = self.getPlaceId {
            let venueUrl = "\(VENUE_BASEURL)\(placeID)"
            WebService().performRequest(url: venueUrl) { (venue: VenueData) in
                self.venue = venue.result
                self.delegate?.didGetVenueData()
            }
        }
    }
    
    var name: String? {
        return venue?.name
    }
    var rating: Double? {
        return venue?.rating
    }
    var placeID: String? {
        return venue?.place_id
    }
    var phone_number: String? {
        return venue?.formatted_phone_number
    }
    var price_level: Int? {
        return venue?.pricelevel
    }
    var vicinity: String?{
        return venue?.vicinity
    }
    var venue_photos: String? {
        var photo_url = ""
        if let photos = self.venue?.photos {
            photo_url = photos[0].photo_reference
        }
        return photo_url
    }
    var venue_reviews: [VenueReviews] {
        var reviews: [VenueReviews] = []
        if let review = venue?.reviews {
            reviews = review
        }
        return reviews
    }
}
