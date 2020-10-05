//
//  HomeViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 5.10.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: class {
    func didGetHomeData()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelProtocol?
    private var attractions: [AttractionsMenuResult?] = []
    private var suggestions: [SuggestionMenuResult?] = []
    private var categories: [CategoryMenuResult?] = []
    
    func numberOfAttractions() -> Int {
        return self.attractions.count
    }
    
    func attractionAtIndex(_ index: Int) -> AttractionsMenuResult? {
        return attractions[index]
    }
    
    func numberOfSuggestions() -> Int {
        return self.suggestions.count
    }
    
    func suggestionAtIndex(_ index: Int) -> SuggestionMenuResult? {
        return suggestions[index]
    }
    
    func numberOfCategory() -> Int {
        return self.categories.count
    }
    
    func categoryAtIndex(_ index: Int) -> CategoryMenuResult? {
        return categories[index]
    }
    
    func getAttractionsMenu(){
        NetworkManager().performRequest(url: ATTRACTIONS_MENUURL) { [weak self] (response: NetworkResponse<AttractionsMenuData, NetworkError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let result):
                self.attractions = result.results
                self.delegate?.didGetHomeData()
                break
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
    
    func getSuggestionData() {
        NetworkManager().performRequest(url: ADS_MENUURL) { [weak self] (response: NetworkResponse<SuggestionsMenuData, NetworkError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let result):
                self.suggestions = result.results
                self.delegate?.didGetHomeData()
                break
            case .failure(let error):
                print(error.errorMessage)
            }
            
        }
    }
    
    func getCategoryMenu() {
        NetworkManager().performRequest(url: CATEGORY_MENUURL) { [weak self] (response: NetworkResponse<CategoryMenuData, NetworkError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let result):
                self.categories = result.results
                self.delegate?.didGetHomeData()
                break
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
}
