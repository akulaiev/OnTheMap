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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listTableView.reloadData()
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout {
            self.performSegue(withIdentifier: "logOut", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LocationModel.mapData.count > 0 {
            return LocationModel.mapData.count
        }
        return 1
    }
    
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
}
