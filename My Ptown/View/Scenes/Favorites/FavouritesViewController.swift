//
//  FavouritesViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 11.08.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    //MARK: -Properties
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noFavouritesLabel: UILabel!
    @IBOutlet weak var noDataImage: UIImageView!
    var favouritesListViewModel: FavouritesViewModel = FavouritesViewModel()
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        getData()
    }
    
    //MARK: -Helpers
    private func prepareUI() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        favouritesTableView.tableFooterView = UIView() //Deleting separators between empty rows
        activityIndicator.startAnimating()
        favouritesTableView.isHidden = true
    }
    
    private func configureUI() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        favouritesTableView.isHidden = false
        if favouritesListViewModel.favouriteVenues.count != 0 {
            noFavouritesLabel.isHidden = true
            noDataImage.isHidden = true
        }
    }
    
    private func getData() {
        favouritesListViewModel.delegate = self
        favouritesListViewModel.getFavouritedVenues()
    }
}

//MARK: -UITableViewDataSource
extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesListViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as! CategoryTableViewCell
        let vm = favouritesListViewModel.cellForRow(at: indexPath.row)
        cell.setFavouritesView(venueName: vm?.name,
                               imageURL: vm?.photos?.first?.photo_reference,
                               vicinity: vm?.vicinity,
                               rating: vm?.rating)
        return cell
    }
}

//MARK: -UITableViewDelegate
extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "VenueDetailsViewController") as! VenueViewContoller
        let vm = self.favouritesListViewModel.cellForRow(at: indexPath.row)
        detailVC.venueViewModel.getPlaceId = vm?.place_id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: -FavouritesListViewModelProtocol
extension FavouritesViewController: FavouritesViewModelProtocol {
    func didGetFavouritedData() {
        DispatchQueue.main.async {
            self.favouritesTableView.reloadData()
            self.configureUI()
        }
    }
}
