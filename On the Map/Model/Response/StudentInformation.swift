//
//  StudentLocation.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/24/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct LocationsResponse: Decodable {
    var results: [StudentInformation]
}

struct StudentInformation: Codable {
    var objectId: String
    private var mediaUrl: String?
    private var mediaURL: String?
    var firstName: String
    private var longtitude: Double?
    private var longitude: Double?
    var latitude: Double?
    var mapString: String
    var lastName: String
    
    func isValid() -> Bool {
        return latitude != nil
    }
    
    func getMediaUrl() -> String {
        if let url = self.mediaURL {
            return url
        }
        if let url = self.mediaUrl {
            return url
        }
        return ""
    }
    
    func getLongitude() -> Double {
        if let longitude = self.longitude {
            return longitude
        }
        if let longitude = self.longtitude {
            return longitude
        }
        return 0.0
    }
}
