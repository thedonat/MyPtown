//
//  CategoryMapViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 2.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import MapKit

class CategoryMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapDetailsView: UIView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeRatingLabel: UILabel!
    var categoryAddresses: [Results?] = []
    var categoryListViewModel: CategoryListViewModel = CategoryListViewModel()
    var placeID: String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureUI()
        zoomToRegion()
        createAnnotations()
        addGestureRecognizer()
    }
    
    func configureUI() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func createAnnotations() {
        for i in 0...categoryAddresses.count - 1 {
            let annotation = MKPointAnnotation()
            if let place = categoryAddresses[i] {
                annotation.title = place.name
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)
                mapView.addAnnotation(annotation)
            }
        }
    }
    func zoomToRegion() {
        let center = CLLocationCoordinate2D(latitude: 42.058441, longitude: -70.178643)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.setRegion(region, animated: true)
    }
    
    func addGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(detailViewTapped))
        mapDetailsView.addGestureRecognizer(gesture)
    }
    
    @objc func detailViewTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "VenueDetailsViewController") as! VenueViewContoller
        detailVC.venueViewModel.getPlaceId = placeID
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CategoryMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            
            pinView?.image = UIImage(named: "map")
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let title = view.annotation?.title {
            if let title = title {
                let info = categoryAddresses.filter { ($0?.name.contains(title)) ?? false}
                let placeInfo = info[0]
                self.placeID = placeInfo?.place_id
                placeNameLabel.text = placeInfo?.name
                if let rating = placeInfo?.rating {
                    let color = setRatingLabelColor(rating: rating)
                    placeRatingLabel.clipsToBounds = true
                    placeRatingLabel.layer.cornerRadius = 3
                    placeRatingLabel.backgroundColor = color
                    placeRatingLabel.text = "\(rating)"
                }
            }
        }
        mapDetailsView.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        mapDetailsView.isHidden = true
    }
}

