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
        searchRequest.naturalLanguageQuery = "market"
        
        // Include only point of interest results. This excludes results based on address matches.
        searchRequest.resultTypes = .pointOfInterest
        
        let localSearch = MKLocalSearch(request: searchRequest)
        
        localSearch.start { [unowned self] (response, error) in
            guard error == nil else {
                self.loadingPlaces = false
                //self.displaySearchError(error)
                return
            }
            
            self.places = response?.mapItems ?? []
            self.loadingPlaces = false
 
        }
    }
    
    
    func arrivalTimeWalking(of origin: CLLocationCoordinate2D?, to destination: CLLocationCoordinate2D, _ completion: @escaping (String) -> Void) {
        
        if let originCoordinate = origin {
            let source = MKPlacemark(coordinate: originCoordinate)
            let destination = MKPlacemark(coordinate: destination)
            request.source = MKMapItem(placemark: source)
            request.destination = MKMapItem(placemark: destination)
            
            // Specify the transportation type
            request.transportType = .walking
            
            let directions = MKDirections(request: request)
            directions.calculate { (response, error) in
                if let response = response, let route = response.routes.first {
                    completion("\(route.expectedTravelTime.string(style: .short)) a pé • \(Int(route.distance)) m")
                }
            }
        }
    }

}

