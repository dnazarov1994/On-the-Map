//
//  AddLocation.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/30/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var linkTextField: UITextField!
    
    @IBAction func findLocation(_ sender: Any) {
        
        guard let mediaUrl = linkTextField.text, !mediaUrl.isEmpty, let location = locationTextField.text, !location.isEmpty else {
            showAlert(title: "ERROR", message: "Fill all fields.")
            return
        }
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowLocationViewController {
            vc.mapString = locationTextField.text ?? ""
            vc.mediaUrl = linkTextField.text ?? ""
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}


