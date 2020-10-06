//
//  SearchViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 23.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol SearchViewModelProtocol: class {
    func didGetSearchData()
}

class SearchViewModel {
    weak var delegate: SearchViewModelProtocol?
    var searchResult: [SearchResult?] = []
    var getSearchedText: String?
    
    var numberOfRows: Int {
        return searchResult.count
    }
    
    func cellForRow(at index: Int) -> SearchResult? {
        return searchResult[index]
    }
    
    func getSearchData() {
        if let text = self.getSearchedText {
            let searchingUrl = "\(SEARCH_URL)\(text)"
            NetworkManager().performRequest(url: searchingUrl) { [weak self] (response: Result<SearchData, NetworkError>) in
                guard let self = self else { return }
                
                switch response {
                case .success(let result):
                    self.searchResult = result.results
                    self.delegate?.didGetSearchData()
                    break
                case .failure(let error):
                    print(error.errorMessage)
                }
            }
        }
    }
}
