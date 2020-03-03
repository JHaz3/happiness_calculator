//
//  EntryListTableViewController.swift
//  NotificationPatternsJournal
//
//  Created by Jake Haslam on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit
//creating a notification key that we can call from anywhere, also known as a  global property
let notificationKey = Notification.Name(rawValue: "didChangeHappiness")

class EntryListTableViewController: UITableViewController {
    
    var averageHappiness: Int = 0 {
        //property Observer it is observing this property and it will fire when its property gets set
        didSet {
            //Shouting our that we just wpdated our average happiness
            NotificationCenter.default.post(name: notificationKey, object: self.averageHappiness)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else {return UITableViewCell()}
        let entry = EntryController.entries[indexPath.row]
        cell.setEntry(entry: entry, averageHappiness: 0)
        //telling our runner who to give tasks to
        cell.delegate = self

        return cell
    }
    
    func updateAverageHappiness() {
        var totalHappiness = 0
        for entry in EntryController.entries {
            if entry.isIncluded {
                totalHappiness += entry.happiness
            }
            averageHappiness = totalHappiness / EntryController.entries.count
        }
    }
}//End Of Class

//Creating our Intern who will do stuff
extension EntryListTableViewController: EntryTableViewCellDelegate {
    //creating the list of instructions for what to do when our intern is told to do something
    func switchToggledOnCell(cell: EntryTableViewCell) {
        guard let entry = cell.entry else {return}
        EntryController.updateEntry(entry: entry)
        updateAverageHappiness()
        cell.updateUI(averageHappiness: averageHappiness)
    }
    
}//End of extention
