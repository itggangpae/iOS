//
//  ResultsListVC.swift
//  MapKitUse
//
//  Created by Adam on 2021/03/16.
//

import UIKit
import MapKit

class ResultsListVC: UITableViewController {
    
    var mapItems: [MKMapItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableCell", for: indexPath) as! ResultsTableCell
        
        let row = indexPath.row
        
        if let item = mapItems?[row] {
            cell.nameLabel.text = item.name
            cell.phoneLabel.text = item.phoneNumber
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat             {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let RouteVC = self.storyboard?.instantiateViewController(identifier: "RouteVC")
                as! RouteVC
            
            if let indexPath = self.tableView.indexPathForSelectedRow,
                let destination = mapItems?[indexPath.row] {
                RouteVC.destination = destination
            }
            self.navigationController?.pushViewController(RouteVC, animated: true)
    }

    
}
