//
//  UIViewControlle+showError.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 4/14/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func show(error: Error) {
        showAlert(title: "ERROR", message: error.localizedDescription)
    }
    
    func showAlert(title: String? = nil, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}
