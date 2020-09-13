//
//  PtownViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 21.04.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol CategoryListViewModelProtocol: class {
    func didGetCategoryData()
}

class CategoryListViewModel {
    weak var delegate: CategoryListViewModelProtocol?
    var getMenuName: String?
    var getMenuUrl: String?
    var getMenuImage: String?
    var mekanlar: [Results?] = []
    
     func getData() {
        if let categoryBaseUrl = self.getMenuUrl {
            let url = "\(CATEGORY_BASEURL)\(categoryBaseUrl)"
            WebService().performRequest(url: url) { (mekanlar: CategoryData) in
                print(mekanlar.results)
                self.mekanlar = mekanlar.results
                self.delegate?.didGetCategoryData()
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return self.mekanlar.count
    }
    
    func ptownAtIndex(_ index: Int) -> CategoryViewModel? {
        if let mekan = self.mekanlar[index] {
            return CategoryViewModel(mekan: mekan)
        }
        return nil
    }
    
    func getLocations() -> [Location?] {
        var locations = [Location?]()
        for mekan in self.mekanlar {
            locations.append(mekan?.geometry.location)
        }
        return locations
    }
}

struct CategoryViewModel {
    let mekan: Results
    var name: String {
        return self.mekan.name
    }
    var placeId : String? {
        return mekan.place_id
    }
    var rating: Double? {
        return self.mekan.rating
    }
    var totalRating: Int? {
        return self.mekan.user_ratings_total
    }
    var icon: String? {
        return self.mekan.icon
    }
    var latitude: Double? {
        return self.mekan.geometry.location.lat
    }
    var longitude: Double? {
        return self.mekan.geometry.location.lng
    }
}
