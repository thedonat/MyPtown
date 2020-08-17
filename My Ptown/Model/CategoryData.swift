//
//  ProvincetownData.swift
//  My Ptown
//
//  Created by Burak Donat on 7.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct CategoryData: Codable{
    let results: [Results]
}

struct Results: Codable {
    let name: String
    let place_id: String
    let icon: String?
    let rating: Double?
    let user_ratings_total: Int?
}

