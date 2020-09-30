//
//  SearchPlaceViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 23.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class SearchPlaceViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchInfoLabel: UILabel!
    var searchListViewModwl: SearchListViewModel = SearchListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        prepareUI()
        getData()
    }
    
    private func prepareUI() {
        navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.searchTableView.tableFooterView = UIView() //Deleting separators between empty rows
        self.searchTableView.keyboardDismissMode = .onDrag //Dismissing keyboard when user scroll down or tap on the tableview.
    }
    
    private func configureUI() {
        if searchListViewModwl.searchResult.count == 0 {
            self.searchInfoLabel.isHidden = false
            self.searchInfoLabel.text = "There is no result found"
            
        } else {
            self.searchInfoLabel.isHidden = true
        }
    }
    
    func getData() {
        searchListViewModwl.delegate = self
        searchListViewModwl.getData()
    }
}

extension SearchPlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchListViewModwl.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let vm = searchListViewModwl.cellForRow(at: indexPath.row)
        cell.setView(icon: vm?.icon,
                     name: vm?.name,
                     rating: vm?.rating,
                     totalRating: vm?.userRatingsTotal)
        return cell
    }
}

extension SearchPlaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = self.searchListViewModwl.cellForRow(at: indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let venueVC = storyboard.instantiateViewController(withIdentifier: "VenueDetailsViewController") as! VenueViewContoller
        if let placeID = vm?.placeID {
            venueVC.venueViewModel.getPlaceId = placeID
        }
        self.navigationController?.pushViewController(venueVC, animated: true)
    }
}

extension SearchPlaceViewController: SearchListViewModelProtocol {
    func didUpdateData() {
        DispatchQueue.main.async {
            self.configureUI()
            self.searchTableView.reloadData()
        }
    }
}

extension SearchPlaceViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text  else {return}
        if searchText != "" {
            let searchedText = searchText.replacingOccurrences(of: " ", with: "+")
            searchListViewModwl.getSearchedText = searchedText
            self.getData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text  else {return}
        if searchText == "" {
            searchListViewModwl.searchResult = []
            searchTableView.reloadData()
            searchInfoLabel.isHidden = false
            self.searchInfoLabel.text = "Search for restaurant, bar or anything"
        }
    }
}
