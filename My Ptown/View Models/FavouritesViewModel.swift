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
    func cellForRow(at index: Int) -> FavouritesViewModel? {
        if let favouriteVenue = self.favouriteVenues[index] {
            return FavouritesViewModel(venue: favouriteVenue)
        }
        return nil
    }
    
    func getFavouritedVenues() {
        self.favouriteVenues = []
        if let favouritedPlaceIDs = defaults.value(forKey: FAVPLACES) as? [String] {
            for id in favouritedPlaceIDs {
                let url = "\(VENUE_BASEURL)\(id)"
                WebService().performRequest(url: url, completion: { (venueResult: VenueData) in
                    self.favouriteVenues.append(venueResult.result)
                    self.delegate?.didGetFavouritedData()
                })
            }
            self.delegate?.didGetFavouritedData()
        } else {
            self.delegate?.didGetFavouritedData()
        }
    }
}

class FavouritesViewModel {
    private let venue: VenueResult
    init(venue: VenueResult) {
        self.venue = venue
    }
    var name: String? {
        return self.venue.name
    }
    var rating: Double? {
        return self.venue.rating
    }
    var venue_photos: String? {
        var photo_url = ""
        if let photos = self.venue.photos {
            photo_url = photos[0].photo_reference
        }
        return photo_url
    }
    var vicinity: String? {
        return self.venue.vicinity
    }
    var placeID: String? {
        return self.venue.place_id
    }
    
}
