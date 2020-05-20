//
//  MarketView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 15/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import MapKit

struct MarketView: View {
    
    let request = MKDirections.Request()
    let locationManager = CLLocationManager()
    var place: MKMapItem
    
    @State var expectedTravelTimeWalking: String = "Carregando.."
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                VStack(alignment:.leading, spacing: 4) {
                    Text(place.name ?? "")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.label)
                    Text(expectedTravelTimeWalking)
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(Color("primary"))
                    Text( "\(place.placemark.title ?? "")")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.secondaryLabel)
                }
                Spacer()
                Button(action: {
                    self.openMap()
                }) {
                  Text("Como chegar")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(Color("buttonAction"))
                }
                
            }
            Rectangle()
                .foregroundColor(.secondarySystemBackground)
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
        .onAppear {
            self.arrivalTimeWalking(
                of: self.locationManager.location?.coordinate ?? CLLocationCoordinate2D(),
                to: self.place.placemark.coordinate
            ) { formattedText in
                self.expectedTravelTimeWalking = formattedText
            }
        }
         
    }
    
    func openMap() {
        let mapItem = MKMapItem(placemark: place.placemark)
        mapItem.name = place.name
        mapItem.openInMaps(launchOptions: nil)
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

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView(place: MKMapItem())
    }
}
