//
//  MapViewController.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/24/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SafariServices

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        getStudentLocation()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        UdacityClient.taskForDeleteRequest(url: UdacityClient.Endpoints.logout.url, responseType: SessionResponse.self) { (data, error) in
            if let _ = data {
                UdacityClient.loginData = nil
                self.dismiss(animated: true, completion: nil)
            }
            if let error = error {
                self.show(error: error)
            }
        }
    }
    
    
    @IBAction func refreshButton(_ sender: Any) {
        let allAnnotations = map.annotations
        map.removeAnnotations(allAnnotations)
        getStudentLocation()
    }
    
    func getStudentLocation()  {
        UdacityClient.taskForGetRequest(url: UdacityClient.Endpoints.studentLocations.url, responseType: LocationsResponse.self) { (data, error) in
            if let data = data {
                self.showOnMap(data: data.results)
            }
            if let error = error {
                self.show(error: error)
            }
        }
    }
    
    func showOnMap(data: [StudentInformation]) {
        data.forEach { (location) in
            guard location.isValid(), let latitude = location.latitude else { return }
            let point = MKPointAnnotation()
            point.title = "\(location.firstName) \(location.lastName)"
            point.subtitle = "\(location.getMediaUrl())"
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: location.getLongitude())
            point.coordinate = coordinate
            map.addAnnotation(point)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
    
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard control == view.rightCalloutAccessoryView else { return }
        if let title = view.annotation?.subtitle, let text = title?.applyTransportProtocol(), let url = URL(string: text) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
}

