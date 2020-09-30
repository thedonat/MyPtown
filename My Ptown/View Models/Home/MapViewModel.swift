//
//  MapViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 30.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol MapViewModelProtocol: class {
    func getMapData()
}

class MapViewModel {
    weak var delegate: MapViewModelProtocol?
    var categoryAddresses: [Results?] = []
    var annotation: MKPointAnnotation = MKPointAnnotation()

    func createAnnotations(){
        for i in 0...categoryAddresses.count - 1 {
            let annotation = MKPointAnnotation()
            if let place = categoryAddresses[i] {
                annotation.title = place.name
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)
                self.annotation = annotation
                self.delegate?.getMapData()
            }
        }
    }
}
