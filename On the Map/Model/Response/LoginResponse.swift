//
//  LoginResponse.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/23/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

struct LoginResponse:Codable {
    let account:Account
    let session:Session
}

