//
//  SuggestionsViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 18.07.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol SuggestionsListViewModelProtocol: class {
    func didGetData()
}

class SuggestionsListViewModel {
    weak var delegate: SuggestionsListViewModelProtocol?
    var suggestions: [SuggestionMenuResult?] = []
    
    func numberOfItemInSection() -> Int {
        return self.suggestions.count
    }
    
    func suggestionAtIndex(_ index: Int) -> SuggestionsViewModel? {
        if let suggestion = self.suggestions[index] {
            return SuggestionsViewModel(suggestion: suggestion)
        }
        return nil
    }
    func getSuggestionData() {
        WebService().performRequest(url: ADS_MENUURL) { (suggesions: SuggestionsMenuData) in
            self.suggestions = suggesions.results
            self.delegate?.didGetData()
        }
    }
}

struct SuggestionsViewModel {
    let suggestion: SuggestionMenuResult
    var image_url: String {
        return self.suggestion.image_url
    }
    var venue_description: String {
        return self.suggestion.venue_description
    }
    var name: String {
        return self.suggestion.name
    }
    var place_id: String {
        return self.suggestion.place_id
    }
    var key: String {
        return self.suggestion.api
    }
}
