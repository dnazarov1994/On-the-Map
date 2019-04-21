//
//  File.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/19/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    var password: String
    var username: String
}

struct UdacityRequest: Codable {
    var udacity: LoginRequest
}
