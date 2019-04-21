//
//  Session.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/23/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct SessionResponse:Codable {
    var session: Session
}

struct Session:Codable {
    var expiration: String
    var id: String
}
