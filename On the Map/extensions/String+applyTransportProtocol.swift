//
//  String+applyTransportProtocol.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/26/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation

extension String {
    func applyTransportProtocol() -> String {
        if self.hasPrefix("http://") || self.hasPrefix("https://") {
            return self
        } else {
            let http = "http://"
            return http + self
        }
    }
}
