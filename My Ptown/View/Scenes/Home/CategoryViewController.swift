//
//  ViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 6.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryViewController: UIViewController, UIScrollViewDelegate {
    
//MARK: -Properties
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var menuTopImage: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var openMapButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var categoryListViewModel: CategoryViewModel = CategoryViewModel()
    var headerView: UIView!
    var kTableHeaderHeight:CGFloat = 400.0
    
//MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addStrechyHeader()
        prepareUI()
        getData()
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderView(view: headerView, tableView: categoryTableView)
    }
    
//MARK: -Helpers
    private func getData() {
        categoryListViewModel.delegate = self
        categoryListViewModel.getCategoryData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView(view: headerView, tableView: categoryTableView)
    }
    
    func addStrechyHeader(){
        categoryTableView.rowHeight = UITableView.automaticDimension
        headerView = categoryTableView.tableHeaderView
        categoryTableView.tableHeaderView = nil
        categoryTableView.addSubview(headerView)
        categoryTableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        categoryTableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView(view: headerView, tableView: categoryTableView)
    }
    
    private func prepareUI() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.categoryTableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func congigureUI() {
        openMapButton.isHidden = false
        if let menuImageUrl = self.categoryListViewModel.getMenuImage, let menuName = self.categoryListViewModel.getMenuName {
            let url = URL(string: menuImageUrl)
            menuTopImage.kf.setImage(with: url, placeholder: UIImage(named: "logo"))
            menuNameLabel.text = menuName
        }
        self.categoryTableView.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    @IBAction func openMapButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = storyboard.instantiateViewController(withIdentifier: "CategoryMapViewController") as! CategoryMapViewController
        navigationController?.pushViewController(mapVC, animated: true)
        mapVC.mapViewModel.categoryAddresses = categoryListViewModel.mekanlar
    }
    
}

//MARK: -UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CategoryTableViewCell
        let vm = self.categoryListViewModel.ptownAtIndex(indexPath.row)
        cell.setView(venueName: vm?.name,
                     rating: vm?.rating,
                     totalRating: vm?.user_ratings_total,
                     icon: vm?.icon)
        return cell
    }
}

//MARK: -UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "VenueDetailsViewController") as! VenueViewContoller
        if categoryListViewModel.ptownAtIndex(indexPath.row)?.rating != 0.0 {
            let vm = self.categoryListViewModel.ptownAtIndex(indexPath.row)
            detailVC.venueViewModel.getPlaceId = vm?.place_id
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            noDataAlert(title: "Ops", message: "There is no data for this place")
        }
    }
}

//MARK: -CategoryListViewModelProtocol
extension CategoryViewController: CategoryViewModelProtocol {
    func didGetCategoryData() {
        DispatchQueue.main.async {
            self.categoryTableView.reloadData()
            self.congigureUI()
        }
    }
}
