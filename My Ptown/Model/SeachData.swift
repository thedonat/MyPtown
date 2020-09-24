//
//  SeachData.swift
//  My Ptown
//
//  Created by Burak Donat on 23.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

// MARK: - SearchData
struct SearchData: Codable {
    let results: [SearchResult]
}

// MARK: - Result
struct SearchResult: Codable {
    let icon: String?
    let name: String?
    let place_id: String?
    let rating: Double?
    let user_ratings_total: Int?
}
