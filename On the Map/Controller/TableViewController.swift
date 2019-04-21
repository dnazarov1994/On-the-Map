//
//  TableViewController.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/26/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [StudentInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("will appear")
        getStudentLocation()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        UdacityClient.taskForDeleteRequest(url: UdacityClient.Endpoints.logout.url, responseType: SessionResponse.self) { (data, error) in
        if let _ = data {
            UdacityClient.loginData = nil
                self.dismiss(animated: true, completion: nil)
            }
            if let error = error {
                self.show(error: error)
            }
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        getStudentLocation()
    }
    
    
    func getStudentLocation()   {
        UdacityClient.taskForGetRequest(url: UdacityClient.Endpoints.studentLocations.url, responseType: LocationsResponse.self) { (data, error) in
            if let data = data {
                self.data = self.filter(data: data.results)
                self.tableView.reloadData()
            } else if let error = error {
                self.show(error: error)
            }
        }
    }
    
    func filter(data: [StudentInformation]) -> [StudentInformation] {
        return data.filter({ (studentInformation) -> Bool in
            return studentInformation.isValid()
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(data[indexPath.row].firstName) \(data[indexPath.row].lastName)"
        cell.detailTextLabel?.text = data[indexPath.row].getMediaUrl()
        cell.imageView?.image = UIImage(named: "icon_pin")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}


