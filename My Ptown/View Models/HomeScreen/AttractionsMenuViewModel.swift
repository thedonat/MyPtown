//
//  AttractionsMenuViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 20.07.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation
protocol AttractionsMenuListViewModelProtocol: class {
    func didGetAttractionsData()
}

class AttractionsMenuListViewModel {
    weak var delegate: AttractionsMenuListViewModelProtocol?
    var attractions: [AttractionsMenuResult?] = []
    
    func getAttractionsMenu(){
        WebService().performRequest(url: ATTRACTIONS_MENUURL) { (attraction: AttractionsMenuData) in
            self.attractions = attraction.results
            self.delegate?.didGetAttractionsData()
        }
    }
    
    func numberOfItemInSection() -> Int {
        return self.attractions.count
    }
    
    func attractionAtIndex(_ index: Int) -> AttractionsMenuViewModel? {
        
        if let attraction = self.attractions[index] {
            return AttractionsMenuViewModel(attraction: attraction)
        }
        return nil
    }
}

struct AttractionsMenuViewModel {
    let attraction: AttractionsMenuResult
    var name: String {
        return self.attraction.name
    }
    var endpoint: String {
        return self.attraction.endpoint
    }
    var image_url: String {
        return self.attraction.image_url
    }
}
