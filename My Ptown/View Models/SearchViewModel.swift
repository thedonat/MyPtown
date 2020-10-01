//
//  SearchViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 23.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol SearchListViewModelProtocol: class {
    func didUpdateData()
}

class SearchListViewModel {
    weak var delegate: SearchListViewModelProtocol?
    var searchResult: [SearchResult?] = []
    var getSearchedText: String?
    
    var numberOfRows: Int {
        return searchResult.count
    }
    
    func cellForRow(at index: Int) -> SearchViewModel? {
        if let place = self.searchResult[index] {
            return SearchViewModel(searchedPlace: place)
        }
        return nil
    }
    
    func getData() {
        if let text = self.getSearchedText {
            let searchingUrl = "\(SEARCH_URL)\(text)"
            WebService().performRequest(url: searchingUrl) { (search: SearchData) in
                self.searchResult = search.results
                self.delegate?.didUpdateData()
            }
        }
    }
}

class SearchViewModel {
    let searchedPlace: SearchResult
    init(searchedPlace: SearchResult) {
        self.searchedPlace = searchedPlace
    }
    
    var icon: String? {
        return searchedPlace.icon
    }
    
    var name: String? {
        return searchedPlace.name
    }
    
    var placeID: String? {
        return searchedPlace.place_id
    }

    var rating: Double? {
        return searchedPlace.rating
    }

    var userRatingsTotal: Int? {
        return searchedPlace.user_ratings_total
    }
}
