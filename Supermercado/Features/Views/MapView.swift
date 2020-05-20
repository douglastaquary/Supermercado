    //
//  MapView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 15/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var locationManager: CLLocationManager
    @Binding var showMapAlert: Bool
    @Binding var annotations: [MKPointAnnotation]
    
    let mapView = MKMapView()
    let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    func makeUIView(context: Context) -> MKMapView {
        locationManager.delegate = context.coordinator
        mapView.delegate = context.coordinator
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
         //Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
                
         mapView.addAnnotations(self.annotations)
    }

    ///Use class Coordinator method
    func makeCoordinator() -> MapView.Coordinator {
      return Coordinator(mapView: self)
    }

    //MARK: - Core Location manager delegate
    class Coordinator: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
        
        var mapView: MapView
        
        init(mapView: MapView) {
            self.mapView = mapView
        }

      ///Switch between user location status
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .restricted:
                break
            case .denied:
                mapView.showMapAlert.toggle()
                return
            case .notDetermined:
                mapView.locationManager.requestWhenInUseAuthorization()
                return
            case .authorizedWhenInUse:
                return
            case .authorizedAlways:
                mapView.locationManager.allowsBackgroundLocationUpdates = true
                mapView.locationManager.pausesLocationUpdatesAutomatically = false
                return
            @unknown default:
                break
            }
            mapView.locationManager.startUpdatingLocation()
        }
        

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }

            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }

            return annotationView
        }
        
    }
}
    

//-23.5965911, -46.6867937
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationManager: .constant(CLLocationManager()), showMapAlert: .constant(false), annotations: .constant([MKPointAnnotation.example]))
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Home"
        annotation.subtitle = "Any where street"
        annotation.coordinate = CLLocationCoordinate2D(latitude: -23.5965911, longitude: -46.6867937)
        return annotation
    }
}
