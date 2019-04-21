//
//  ShowLocationViewController.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 4/9/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ShowLocationViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var mediaUrl: String!
    var mapString: String!
    var latitude = 37.386052
    var longtitude = -122.083851
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        showOnMap()
    }
    
    @IBAction func finishButton(_ sender: Any) {
        
        UdacityClient.taskForGetRequest(url: UdacityClient.Endpoints.userInfo.url, responseType: User.self) { (value, error) in
            if let error = error {
                self.show(error: error)
            }
            if let value = value {
                guard let key = UdacityClient.loginData?.account.key else { return }
                let locationObject = LocationRequest(uniqueKey: key,
                                                     firstName: value.firstName,
                                                     lastName: value.lastName,
                                                     mapString: self.mapString,
                                                     mediaUrl: self.mediaUrl,
                                                     latitude: self.latitude,
                                                     longtitude: self.longtitude)
                self.postLocation(with: locationObject)
            }
        }
    }
    
    func postLocation(with object: LocationRequest) {
        UdacityClient.taskForPOSTRequest(url: UdacityClient.Endpoints.postLocation.url, responseType: PostLocationResponse.self, body: object) { (value,error) in
            if let value = value {
                self.dismiss(animated: true, completion: nil)
            }
            if let error = error {
                self.show(error: error)
            }
        }
    }
    
    func showOnMap() {
        let annonation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longtitude)
        annonation.coordinate = coordinate
        annonation.title = self.mapString
        mapView.addAnnotation(annonation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = "newpin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pin) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pin)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
}


