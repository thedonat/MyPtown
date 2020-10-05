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
    
    func cellForRow(at index: Int) -> SearchResult? {
        return searchResult[index]
    }
    
    func getData() {
        if let text = self.getSearchedText {
            let searchingUrl = "\(SEARCH_URL)\(text)"
            NetworkManager().performRequest(url: searchingUrl) { [weak self] (response: NetworkResponse<SearchData, NetworkError>) in
                guard let self = self else { return }
                
                switch response {
                case .success(let result):
                    self.searchResult = result.results
                    self.delegate?.didUpdateData()
                    break
                case .failure(let error):
                    print(error.errorMessage)
                }
            }
        }
    }
}
