//
//  PtownViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 21.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

struct PtownListViewModel {
    var mekanlar: [Results]
    
    func numberOfRowsInSection() -> Int {
        return self.mekanlar.count
    }
    func ptownAtIndex(_ index: Int) -> CategoryViewModel {
        let mekan = self.mekanlar[index]
        return CategoryViewModel(mekan: mekan)
    }
}

struct CategoryViewModel {
    let mekan: Results
    var name: String {
        return self.mekan.name
    }
    var vicinity: String {
        return self.mekan.vicinity
    }
    var photoUrl: String {
        var photoUrl = ""
        if let photos = self.mekan.photos {
            photoUrl = photos[0].photo_reference
        }
        return photoUrl
    }
    var placeId : String {
        return mekan.place_id
    }
    var rating: Double {
        var rating = 0.0
        if let venueRating = self.mekan.rating {
            rating = venueRating
        }
        return rating
     }
}


//        if let photoUrl = self.mekan.photos[0].photo_reference {
//            return photoUrl
//        }
