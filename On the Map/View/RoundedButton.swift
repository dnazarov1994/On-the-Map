//
//  File.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/17/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton:UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

