//
//  FavouritesViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 11.08.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol FavouritesListViewModelProtocol: class {
    func didGetFavouritedData()
}

class FavouritesListViewModel {
    weak var delegate: FavouritesListViewModelProtocol?
    var favouriteVenues: [VenueResult?] = []
    private let defaults = UserDefaults.standard
    
    var numberOfRows: Int {
        return favouriteVenues.count
    }
    
    func cellForRow(at index: Int) -> VenueResult? {
        return favouriteVenues[index]
    }
    
    func getFavouritedVenues() {
        self.favouriteVenues = []
        if let favouritedPlaceIDs = defaults.value(forKey: FAVPLACES) as? [String] {
            for id in favouritedPlaceIDs {
                let url = "\(VENUE_BASEURL)\(id)"
                NetworkManager().performRequest(url: url, completion: { [weak self] (response: NetworkResponse<VenueData, NetworkError>) in
                    guard let self = self else { return }
                    
                    switch response {
                    case .success(let result):
                        self.favouriteVenues.append(result.result)
                        self.delegate?.didGetFavouritedData()
                        break
                    case .failure(let error):
                        print(error.errorMessage)
                    }
                    
                })
            }
            self.delegate?.didGetFavouritedData()
        } else {
            self.delegate?.didGetFavouritedData()
        }
    }
}
