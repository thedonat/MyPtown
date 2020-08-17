//
//  ViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 6.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UIScrollViewDelegate {
//MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuTopImage: UIImageView!
    
    private var ptownListViewModel: CategoryListViewModel!
    var imageUrl: String = ""
    var getMenuName = String()
    var getMenuUrl = String()
    var getMenuImage = UIImage()
    var headerView: UIView!
    var kTableHeaderHeight:CGFloat = 400.0
    
//MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        congigureUI()
        getData()
        addStrechyHeader()
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func addStrechyHeader(){
        tableView.rowHeight = UITableView.automaticDimension
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "GillSans-Bold", size: 35)
        label.text = getMenuName
        headerView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        updateHeaderView()
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    
    func congigureUI() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        menuTopImage.image = getMenuImage
    }

    private func getData() {
        let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=42.051932,-70.185611&radius=200&type=\(getMenuUrl)&key=AIzaSyATywHWyquPTWxl2IIt9eNSPdkl4YNBtHs"
        print("DEBUG: Base URL: \(baseUrl)")
        WebService().performRequest(url: baseUrl) { (mekanlar: PtownData) in
            self.ptownListViewModel = CategoryListViewModel(mekanlar: mekanlar.results)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ptownListViewModel == nil ? 0 :  self.ptownListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! MenuDetailsTableViewCell
        let vm = self.ptownListViewModel.ptownAtIndex(indexPath.row)
        cell.setView(venueName: vm.name, addressName: vm.vicinity, imageURL: vm.photoUrl, rating: vm.rating)
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "VenueDetailsViewController") as! VenueDetailsViewController
        detailVC.getPlaceId = self.ptownListViewModel.ptownAtIndex(indexPath.row).placeId
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
