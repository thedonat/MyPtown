//
//  HomeViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 28.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var homeTopView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var adsCollectionView: UICollectionView!
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    @IBOutlet weak var homeTopImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var suggestedListViewModel: SuggestionsListViewModel = SuggestionsListViewModel()
    var categoryMenuListViewModel: CategoryMenuListViewModel = CategoryMenuListViewModel()
    var attractionMenuListViewModel: AttractionsMenuListViewModel = AttractionsMenuListViewModel()
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        getData()
    }
    //MARK: -Helpers
    private func getData() {
        suggestedListViewModel.delegate = self
        suggestedListViewModel.getSuggestionData()
        categoryMenuListViewModel.delegate = self
        categoryMenuListViewModel.getCategoryMenu()
        attractionMenuListViewModel.delegate = self
        attractionMenuListViewModel.getAttractionsMenu()
    }
    
    private func prepareUI() {
        scrollView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        homeTopImageView.layer.cornerRadius = 10
        homeTopImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.setDimensions(width: 44, height: 44)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    private func configureUI() {
        scrollView.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        if let key = self.suggestedListViewModel.suggestionAtIndex(0)?.key {
            API_KEY = key
        }
    }
}
//MARK: -UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollectionView {
            return suggestedListViewModel.numberOfItemInSection()
        }
        else if collectionView == menuCollectionView {
            return categoryMenuListViewModel.numberOfItemInSection()
        }
        else {
            return attractionMenuListViewModel.numberOfItemInSection()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == menuCollectionView){
            let cell1 = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            let vm = self.categoryMenuListViewModel.categoryAtIndex(indexPath.row)
            cell1.setView(menu: vm?.name, menuUrl: vm?.image_url)
            return cell1
        }
        else if (collectionView == activitiesCollectionView) {
            let cell3 = activitiesCollectionView.dequeueReusableCell(withReuseIdentifier: "activitiesCollectionViewCell", for: indexPath) as! ActivitiesCollectionViewCell
            let vm = self.attractionMenuListViewModel.attractionAtIndex(indexPath.row)
            cell3.setView(name: vm?.name)
            return cell3
        }
        let cell2 = adsCollectionView.dequeueReusableCell(withReuseIdentifier: "adsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
        let vm = self.suggestedListViewModel.suggestionAtIndex(indexPath.row)
        cell2.setView(venue_description: vm?.venue_description, imageUrl: vm?.image_url)
        return cell2
    }
}
//MARK: -UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if collectionView == menuCollectionView {
            let categoryVC = storyboard.instantiateViewController(withIdentifier: "MenuDetailsViewController") as! CategoryViewController
            let vm = self.categoryMenuListViewModel.categoryAtIndex(indexPath.row)
            categoryVC.categoryListViewModel.getMenuName = vm?.name
            categoryVC.categoryListViewModel.getMenuUrl = vm?.endpoint
            categoryVC.categoryListViewModel.getMenuImage = vm?.image_url
            self.navigationController?.pushViewController(categoryVC, animated: true)
        }
        else if collectionView == adsCollectionView{
            let vm = self.suggestedListViewModel.suggestionAtIndex(indexPath.row)
            let venueVC = storyboard.instantiateViewController(withIdentifier: "VenueDetailsViewController") as! VenueViewContoller
            if let placeID = vm?.place_id {
                venueVC.venueViewModel.getPlaceId = placeID
            }
            self.navigationController?.pushViewController(venueVC, animated: true)
        }
        else if collectionView == activitiesCollectionView {
            let vm = self.attractionMenuListViewModel.attractionAtIndex(indexPath.row)
            let categoryVC = storyboard.instantiateViewController(withIdentifier: "MenuDetailsViewController") as! CategoryViewController
            categoryVC.categoryListViewModel.getMenuName = vm?.name
            categoryVC.categoryListViewModel.getMenuUrl = vm?.endpoint
            categoryVC.categoryListViewModel.getMenuImage = vm?.image_url
            self.navigationController?.pushViewController(categoryVC, animated: true)
        }
    }
}
//MARK: -UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let width = (self.view.frame.size.width - 12 * 3)/2 //some width
        let width = (self.view.frame.size.width / 2) //some width

        let height = width * 1.5 //ratio
        return CGSize(width: width, height: height)
    }
}
//MARK: -SuggestionsListViewModelProtocol
extension HomeViewController: SuggestionsListViewModelProtocol {
    func didGetData() {
        DispatchQueue.main.async {
            self.adsCollectionView.reloadData()
        }
    }
}
//MARK: -CategoryMenuListViewModelProtocol
extension HomeViewController: CategoryMenuListViewModelProtocol {
    func didGetMenuData() {
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }
}
//MARK: -AttractionsMenuListViewModelProtocol
extension HomeViewController: AttractionsMenuListViewModelProtocol {
    func didGetAttractionsData() {
        DispatchQueue.main.async {
            self.activitiesCollectionView.reloadData()
            self.configureUI()
        }
    }
}
