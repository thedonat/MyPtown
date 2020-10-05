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
    
    func suggestionAtIndex(_ index: Int) -> SuggestionMenuResult? {
        return suggestions[index]
    }
    
    func getSuggestionData() {
        NetworkManager().performRequest(url: ADS_MENUURL) { [weak self] (response: NetworkResponse<SuggestionsMenuData, NetworkError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let result):
                self.suggestions = result.results
                self.delegate?.didGetData()
                break
            case .failure(let error):
                print(error.errorMessage)
            }

        }
    }
}
