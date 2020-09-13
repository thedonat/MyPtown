//
//  Constants.swift
//  My Ptown
//
//  Created by Burak Donat on 26.07.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

var API_KEY = ""
let CATEGORY_BASEURL = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=Provincetown&key=\(API_KEY)&type="
let VENUE_BASEURL = "https://maps.googleapis.com/maps/api/place/details/json?key=\(API_KEY)&place_id="
let VENUE_IMAGEURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=2000&key=\(API_KEY)&photoreference="
let ADS_MENUURL = "https://my-ptown.firebaseio.com/suggestions.json"
let CATEGORY_MENUURL = "https://my-ptown.firebaseio.com/categories.json"
let ATTRACTIONS_MENUURL = "https://my-ptown.firebaseio.com/attractions.json"
let FAVPLACES = "FAVPLACES"
let NEWS_URL = "https://newsapi.org/v2/everything?q=provincetown&from=2020-08-13&sortBy=publishedAt&apiKey=fa68fee749e04314a452180019ed7fae"
    
