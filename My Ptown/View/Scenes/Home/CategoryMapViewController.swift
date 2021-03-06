//
//  CategoryMapViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 2.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CategoryMapViewController: UIViewController {
    
    //MARK: -Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapDetailsView: UIView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeRatingLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var locationMenager = CLLocationManager()
    var placeID: String? = ""
    var rating: Double? = 0.0
    var mapViewModel: MapViewModel = MapViewModel()
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapViewModel.delegate = self
        mapViewModel.createAnnotations()
        configureUI()
    }
    
    //MARK: -Helpers
    func configureUI() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        zoomToRegion()
        addGestureRecognizer()
    }
    
    func zoomToRegion() {
        let center = CLLocationCoordinate2D(latitude: 42.051591, longitude: -70.185685)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    func addGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(detailViewTapped))
        mapDetailsView.addGestureRecognizer(gesture)
    }
    
    @objc func detailViewTapped() {
        if self.rating != 0.0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "VenueDetailsViewController") as! VenueViewContoller
            detailVC.venueViewModel.getPlaceId = placeID
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            noDataAlert(title: "Ops!", message: "There is no data for this place")
        }
    }
    
    @IBAction func navButtonTapped(_ sender: UIButton) {
        let status = CLLocationManager.authorizationStatus()
        handleAuthorisationStatus(status: status)
        locationMenager.delegate = self
        locationMenager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
    }
    
    func handleAuthorisationStatus (status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            // GPS permission has already been authorised, so start requesting location information
            locationMenager.startUpdatingLocation()
        case .denied, .restricted:
            // GPS permission denied or restricted, so ask user to change setting
            noPermissionAlert()
        case .notDetermined:
            // User hasn't been asked for GPS permission yet, so ask for it
            locationMenager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

//MARK: -MKMapViewDelegate
extension CategoryMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if annotation is MKUserLocation {
            return nil
        }
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
        if view.annotation is MKUserLocation {
            return
        } else {
            if let title = view.annotation?.title {
                if let title = title {
                    let info = mapViewModel.categoryAddresses.filter { ($0?.name.contains(title)) ?? false}
                    let placeInfo = info[0]
                    self.placeID = placeInfo?.place_id
                    self.rating = placeInfo?.rating
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
            self.bottomConstraint.constant = 96
            mapDetailsView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        mapDetailsView.isHidden = true
        self.bottomConstraint.constant = 16
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: -CLLocationManagerDelegate
extension CategoryMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        locationMenager.stopUpdatingLocation()
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinations, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorisationStatus(status: status)
    }
}

//MARK: -MapViewModelProtocol
extension CategoryMapViewController: MapViewModelProtocol {
    func getMapData() {
        mapView.addAnnotation(mapViewModel.annotation)
    }
}
