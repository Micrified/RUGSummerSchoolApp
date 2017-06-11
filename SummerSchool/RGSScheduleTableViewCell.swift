//
//  RGSScheduleTableViewCell.swift
//  SummerSchool
//
//  Created by Charles Randolph on 6/10/17.
//  Copyright © 2017 RUG. All rights reserved.
//

import UIKit

class RGSScheduleTableViewCell: UITableViewCell {
    
    // MARK: - Variables and Constants
    
    /// Event date.
    var date: Date? {
        didSet (oldDate) {
            if (date != nil && date != oldDate) {
                let weekDay: Int = (DataManager.sharedInstance?.calendar.component(.weekday, from: date!))!
                let monthDay: Int =  (DataManager.sharedInstance?.calendar.component(.day, from: date!))!
                let month: Int = (DataManager.sharedInstance?.calendar.component(.month, from: date!))!
                let weekDayString: String = (DataManager.sharedInstance?.weekDays[weekDay - 1])!
                let monthDayPrefix: String = (DataManager.sharedInstance?.prefixForDayOfMonth(monthDay))!
                let monthString: String = (DataManager.sharedInstance?.months[month - 1])!
                dayLabel.text = "\(weekDayString)"
                dateLabel.text = "\(monthString) \(monthDay)\(monthDayPrefix)"
            }
        }
    }
    
    /// Event count.
    var eventCount: Int? {
        didSet (oldEventCount) {
            if (eventCount != nil && eventCount != oldEventCount) {
                let eventCountLabelText: String = "\(eventCount!) event" + ((eventCount! == 1) ? "" : "s")
                eventCountLabel.text = eventCountLabelText
            }
        }
    }
    
    // MARK: - Outlets
    
    /// Day Label
    @IBOutlet weak var dayLabel: UILabel!
    
    /// Date Label
    @IBOutlet weak var dateLabel: UILabel!
    
    /// Event count Label
    @IBOutlet weak var eventCountLabel: UILabel!
    

    // MARK: - Class Method Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
