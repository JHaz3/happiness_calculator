//
//  EntryTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Jake Haslam on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabled: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
    
    // MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLable.text = entry.title
        isEnabled.isOn = entry.isIncluded
        
        //Update higherOrLowerLabel after notifications
    }
    
    
}
