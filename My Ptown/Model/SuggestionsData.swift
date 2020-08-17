//
//  SuggestionsData.swift
//  My Ptown
//
//  Created by Burak Donat on 18.07.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct SuggestionsMenuData: Codable {
    let results: [SuggestionMenuResult]
}

struct SuggestionMenuResult: Codable {
    let api: String
    let name: String
    let image_url: String
    let venue_description: String
    let place_id: String
    
}

struct CategoryMenuData: Codable {
    let results: [CategoryMenuResult]
}

struct CategoryMenuResult: Codable {
    let name: String
    let endpoint: String
    let image_url: String
}

struct AttractionsMenuData: Codable {
    let results: [AttractionsMenuResult]
}

struct AttractionsMenuResult: Codable {
    let name: String
    let endpoint: String
    let image_url: String
}

