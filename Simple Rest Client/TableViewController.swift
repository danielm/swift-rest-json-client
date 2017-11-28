//
//  MyTableViewController.swift
//  Simple Rest Client
//
//  Created by Alvaro Morales on 8/26/17.
//  Copyright © 2017 Daniel Morales. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var housesArray = [WesterosHouse]()
    
    let houseCellID = "houseCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Westeros Houses"
        
        MyServices.singleton.fetchHouses { (houses) in
            self.housesArray = houses
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return housesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: houseCellID) else {
                return UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: houseCellID)
            }
            return cell
        }()

        cell.textLabel?.text = housesArray[indexPath.row].name
        cell.detailTextLabel?.text = housesArray[indexPath.row].motto

        return cell
    }
}

