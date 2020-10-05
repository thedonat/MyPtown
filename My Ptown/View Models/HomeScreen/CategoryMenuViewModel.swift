//
//  CategoryMenuViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 20.07.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol CategoryMenuListViewModelProtocol: class {
    func didGetMenuData()
}

class CategoryMenuListViewModel {
    weak var delegate: CategoryMenuListViewModelProtocol?
    private var categories: [CategoryMenuResult?] = []
    
    func numberOfItemInSection() -> Int {
        return self.categories.count
    }
    
    func categoryAtIndex(_ index: Int) -> CategoryMenuResult? {
        return categories[index]
    }
    
    func getCategoryMenu() {
        NetworkManager().performRequest(url: CATEGORY_MENUURL) { [weak self] (response: NetworkResponse<CategoryMenuData, NetworkError>) in
            guard let self = self else { return }
              
              switch response {
              case .success(let result):
                  self.categories = result.results
                  self.delegate?.didGetMenuData()
                  break
              case .failure(let error):
                  print(error.errorMessage)
              }
            
        }
    }
}
