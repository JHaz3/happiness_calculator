//
//  EntryTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Jake Haslam on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit
//Declaring a protocol  :class allowing it to use class level objects
protocol EntryTableViewCellDelegate: class {
    //Creating a task that the boss(tableViewCell), gave our Intern delegate, tableViewController)
    func switchToggledOnCell(cell: EntryTableViewCell)
}

class EntryTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabled: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
   
    //Delegate our runner 
    weak var delegate: EntryTableViewCellDelegate?
    // MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLable.text = entry.title
        isEnabled.isOn = entry.isIncluded
        
        higherOrLowerLabel.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
     func createObserver() {
        //Creating our person who will listen for our notification, then call recalculate happiness
        NotificationCenter.default.addObserver(self, selector: #selector(recalculateHappiness), name: notificationKey, object: nil)
    }
    
    @objc func recalculateHappiness(notification: NSNotification) {
        guard let averageHappiness = notification.object as? Int else {return}
        updateUI(averageHappiness: averageHappiness)
    }
    
    @IBAction func toggledIsIncluded(_ sender: Any) {
       //Telling our runner to go tell our intern to do something
        delegate?.switchToggledOnCell(cell: self)
    }
    
}//End of Class
