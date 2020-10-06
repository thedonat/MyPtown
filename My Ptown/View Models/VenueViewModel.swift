//
//  VenueViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 22.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol VenueViewModelProtocol: class {
    func didGetVenueData()
}

class VenueViewModel {
    weak var delegate: VenueViewModelProtocol?
    var venue : VenueResult?
    var getPlaceId: String?
    
    init(venue: VenueResult? = nil) {
        self.venue = venue
    }
    
    func getVenueDetails() {
        if let placeID = self.getPlaceId {
            let venueUrl = "\(VENUE_BASEURL)\(placeID)"
            NetworkManager().performRequest(url: venueUrl) { [weak self] (response: Result<VenueData, NetworkError>) in
                guard let self = self else { return }
                
                switch response {
                case .success(let result):
                    self.venue = result.result
                    self.delegate?.didGetVenueData()
                    break
                case .failure(let error):
                    print(error.errorMessage)
                }

            }
        }
    }
}
