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
    var categories: [CategoryMenuResult?] = []
    
    func numberOfItemInSection() -> Int {
        return self.categories.count
    }
    
    func categoryAtIndex(_ index: Int) -> CategoryMenuViewModel? {
        if let category = self.categories[index] {
            return CategoryMenuViewModel(category: category)
        }
        return nil
    }
    
    func getCategoryMenu() {
        WebService().performRequest(url: CATEGORY_MENUURL) { (category: CategoryMenuData) in
            self.categories = category.results
            self.delegate?.didGetMenuData()
        }
    }
}

struct CategoryMenuViewModel {
    let category: CategoryMenuResult
    var image_url: String {
        return self.category.image_url
    }
    var name: String {
        return self.category.name
    }
    var endpoint: String {
        return self.category.endpoint
    }
}
