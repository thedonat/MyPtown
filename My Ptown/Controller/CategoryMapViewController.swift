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
    var categoryAddresses: [Results?] = []
    var categoryListViewModel: CategoryListViewModel = CategoryListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        zoomToRegion()
        createAnnotations()
    }
    
    func createAnnotations() {
        for i in 0...categoryAddresses.count - 1 {
            let annotation = MKPointAnnotation()
            if let place = categoryAddresses[i] {
                annotation.subtitle = "\(place.rating!)"
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
}

extension CategoryMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            pinView?.image = UIImage(named: "map")
            let infoButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.leftCalloutAccessoryView = infoButton
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let selectedCoordinates = view.annotation?.coordinate {
            let selectedLocation = CLLocation(latitude: selectedCoordinates.latitude, longitude: selectedCoordinates.longitude)
            CLGeocoder().reverseGeocodeLocation(selectedLocation) { (placemarks, erro) in
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemarks[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = view.annotation?.title as? String
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
}
