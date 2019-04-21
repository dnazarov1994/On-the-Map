//
//  LocationRequest.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 4/7/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct LocationRequest: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaUrl: String
    var latitude: Double
    var longtitude: Double
}

