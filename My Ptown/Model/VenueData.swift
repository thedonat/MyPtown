//
//  VenueData.swift
//  My Ptown
//
//  Created by Burak Donat on 1.03.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct VenueData: Codable {
    let result: VenueResult
}

struct VenueResult: Codable {
    let name: String
    let rating: Double?
    let formatted_phone_number: String?
    let photos: [VenuePhotos]?
    let reviews: [VenueReviews]?
    let pricelevel: Int?
    let vicinity: String?
    let place_id: String
    let opening_hours: OpeningHours?
}

struct VenuePhotos: Codable {
    let photo_reference: String
}

struct VenueReviews: Codable {
    let author_name: String
    let text: String
    let relative_time_description: String
    let profile_photo_url: String
    let rating: Int
}

struct OpeningHours: Codable {
    let open_now: Bool?
}
