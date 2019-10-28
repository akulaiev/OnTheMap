//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Anna Kulaieva on 10/25/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    //Sets delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    //Reloads table view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listTableView.reloadData()
    }
    
    //Performs logout request and dismisses the view controller
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //Returns number of rows in table according to number of data entries in model
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LocationModel.mapData.count > 0 {
            return LocationModel.mapData.count
        }
        return 1
    }
    
    //Populates reusable cell for row with data and returns it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")!
        if LocationModel.mapData.count > 0 {
            let cellData = LocationModel.mapData[(indexPath as NSIndexPath).row]
            cell.textLabel?.text = cellData.firstName + " " + cellData.lastName
            cell.detailTextLabel?.text = cellData.mediaURL
            cell.imageView?.image = UIImage(named: "icon_pin")
            cell.imageView?.backgroundColor = .clear
        }
        else {
            cell.textLabel?.text = "Loading..."
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    //When user selects a row, function checks if it's Url is valid and handles error or opens it in Safari
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = LocationModel.mapData[(indexPath as NSIndexPath).row].mediaURL
        SharedHelperMethods.checkValidUrl(urlString: urlString, controller: self)
    }
    
    //Deletes the data in Model and performs request to get the new location data. Refreshes table view to show changes
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        LocationModel.mapData.removeAll()
        listTableView.reloadData()
        UdacityClient.getStudentsLocations { (response, error) in
            if let response = response {
                LocationModel.mapData = response.results
                self.listTableView.reloadData()
            }
            else {
                SharedHelperMethods.showFailureAlert(title: "Problem with student locations download", message: error!.localizedDescription, controller: self)
            }
        }
    }
}
