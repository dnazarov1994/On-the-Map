//
//  UserResponse.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 4/6/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
 
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}
