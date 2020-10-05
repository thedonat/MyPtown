//
//  VenueDetailViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 10.02.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import Kingfisher

class VenueViewContoller: UIViewController, UIScrollViewDelegate {
//MARK: -Properties
    @IBOutlet weak var venueDetailsTableView: UITableView!
    @IBOutlet weak var venueTopImage: UIImageView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueLabelView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var headerView: UIView!
    var kTableHeaderHeight:CGFloat = 400.0
    var venueViewModel: VenueViewModel = VenueViewModel()
    
//MARK: -Lifecycle
    override func viewDidLoad() {   
        super.viewDidLoad()
        addStrechyHeader()
        prepareUI()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderView(view: headerView, tableView: venueDetailsTableView)
    }
    
//MARK: -Helpers
    private func getData() {
        self.venueViewModel.delegate = self
        self.venueViewModel.getVenueDetails()
    }
    
    private func prepareUI() {
        venueDetailsTableView.estimatedRowHeight = 300
        venueDetailsTableView.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        activityIndicator.startAnimating()
    }
    
    func addStrechyHeader() {
        venueDetailsTableView.rowHeight = UITableView.automaticDimension
        headerView = venueDetailsTableView.tableHeaderView
        venueDetailsTableView.tableHeaderView = nil
        venueDetailsTableView.addSubview(headerView)
        venueDetailsTableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        venueDetailsTableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView(view: headerView, tableView: venueDetailsTableView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView(view: headerView, tableView: venueDetailsTableView)
    }
    
    private func configureUI() {
        if let photo_url = self.venueViewModel.venue?.photos?.first?.photo_reference {
            let imageUrl = "\(VENUE_IMAGEURL)\(photo_url)"
            let url = URL(string: imageUrl)
            self.venueTopImage.kf.setImage(with: url, placeholder: UIImage(named: "logo"))

        } else {
            self.venueTopImage.image = UIImage(named: "logo")
        }
        venueDetailsTableView.isHidden = false
        venueNameLabel.text = venueViewModel.venue?.name
        venueLabelView.fadeView(percentage: 0.7)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

//MARK: -UITableViewDataSource
extension VenueViewContoller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let reviews = venueViewModel.venue?.reviews?.count {
            return reviews + 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.item == 0 {
            let detailsCell = venueDetailsTableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            detailsCell.setDetails(name: self.venueViewModel.venue?.name,
                                   phone_number: self.venueViewModel.venue?.formatted_phone_number,
                                   vicinity: self.venueViewModel.venue?.vicinity,
                                   placeID: self.venueViewModel.venue?.place_id)
            cell = detailsCell
        }
        else {
            let reviewsCell = venueDetailsTableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as! ReviewsTableViewCell
            if let reviews = venueViewModel.venue?.reviews {
                let venueVM = reviews[indexPath.row - 1]
                reviewsCell.indentationLevel = 2;
                reviewsCell.setReviews(time: venueVM.relative_time_description,
                                       author: venueVM.author_name,
                                       comment: venueVM.text,
                                       profile_photo_url: venueVM.profile_photo_url,
                                       rate: venueVM.rating)
                cell = reviewsCell
            }
        }
        return cell
    }
}

//MARK: -VenueViewModelProtocol
extension VenueViewContoller: VenueViewModelProtocol {
    func didGetVenueData() {
        DispatchQueue.main.async {
            self.venueDetailsTableView.reloadData()
            self.configureUI()
        }
    }
}
