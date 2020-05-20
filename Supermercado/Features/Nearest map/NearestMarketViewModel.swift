//
//  NearestMarketViewModel.swift
//  Supermercado
//
//  Created by Douglas Taquary on 17/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Combine
import Foundation
import MapKit

class NearestMarketViewModel: ObservableObject {
    
    var locationManager = CLLocationManager()
    let request = MKDirections.Request()
    let searchRequest = MKLocalSearch.Request()
    
    var location: CLLocationCoordinate2D {
        return locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    @Published var currentAnnotations: [MKPointAnnotation] = []
    
    // input
    @Published var idsToRemove: [UUID] = []
    @Published var places: [MKMapItem] = []
    @Published var loadingPlaces: Bool = false
    
    // output

    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {}

    func search(to location: CLLocationCoordinate2D) {
        loadingPlaces = true
        
        // Confine the map search area to an area around the user's current location.
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        searchRequest.region = region
        searchRequest.naturalLanguageQuery = "supermarket"
        
        // Include only point of interest results. This excludes results based on address matches.
        searchRequest.resultTypes = .pointOfInterest
        
        let localSearch = MKLocalSearch(request: searchRequest)
        
        localSearch.start { [unowned self] (response, error) in
            guard error == nil else {
                self.loadingPlaces = false
                return
            }
            
            self.places = response?.mapItems ?? []
            self.currentAnnotations = self.setupAnnotationFactory(to: self.places)
            self.loadingPlaces = false
 
        }
    }
    
    func setupAnnotationFactory(to places: [MKMapItem]) -> [MKPointAnnotation] {
        var newPlaces: [MKPointAnnotation] = []
        for place in places {
            let annotation = MKPointAnnotation()
            annotation.coordinate = place.placemark.coordinate
            annotation.title = place.name
            annotation.subtitle = place.placemark.title
            newPlaces.append(annotation)
        }
        
        return newPlaces
    }

}

