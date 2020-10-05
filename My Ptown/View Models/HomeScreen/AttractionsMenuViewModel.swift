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
    private var attractions: [AttractionsMenuResult?] = []
    
    func numberOfItemInSection() -> Int {
        return self.attractions.count
    }
    
    func attractionAtIndex(_ index: Int) -> AttractionsMenuResult? {
        return attractions[index]
    }
    
    func getAttractionsMenu(){
        NetworkManager().performRequest(url: ATTRACTIONS_MENUURL) { [weak self] (response: NetworkResponse<AttractionsMenuData, NetworkError>) in
            guard let self = self else { return }

            switch response {
            case .success(let result):
                self.attractions = result.results
                self.delegate?.didGetAttractionsData()
                break
            case .failure(let error):
                print(error.errorMessage)
            }
            
        }
    }
}


