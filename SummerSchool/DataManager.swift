//
//  DataManager.swift
//  SummerSchool
//
//  Created by Charles Randolph on 6/11/17.
//  Copyright © 2017 RUG. All rights reserved.
//

import Foundation

// MARK: - Structures

/// Structure representing an event.
struct Event {
    var title: String?
    var address: String?
    var description: String?
    var ssid: String?
    var startDate: Date?
    var endDate: Date?
}

/// Extension with initializer for Event.
extension Event {
    init?(json: [String: Any]) {
        guard
            let title: String = json["summary"] as? String,
            let address: String = json["location"] as? String,
            let description: String = json["description"] as? String,
            let start: [String: String] = json["start"] as? [String: String],
            let end: [String: String] = json["end"] as? [String: String],
            let extendedProperties: [String: Any] = json["extendedProperties"] as? [String: Any],
            let shared: [String: String] = extendedProperties["shared"] as? [String: String]
            else {
                return nil
        }
        
        self.title = title
        self.address = address
        self.description = description
        self.ssid = shared["ssid"]
        self.startDate = DataManager.sharedInstance?.ISOStringToDate(start["dateTime"])
        self.endDate = DataManager.sharedInstance?.ISOStringToDate(end["dateTime"])
    }
}

/// Structure representing an event packet received from the server.
struct EventPacket {
    var events: [(Date, [Event])]?
}

/// Extension with initializer for EventPacket.
extension EventPacket {
    init?(json: [[Any]]) {
        
        var events: [(Date, [Event])] = [(Date, [Event])]()
        
        for item in json {
            var parsedEvents: [Event] = [Event]()
            guard
                let dateString: String = item[0] as? String,
                let dateEvents: [Any] = item[1] as? [Any]
                else {
                    return nil
            }
            
            for serializedEvent in dateEvents {
                if let event = Event.init(json: serializedEvent as! [String : Any]) {
                    parsedEvents.append(event)
                } else {
                    return nil
                }
            }
            let date: Date? = DataManager.sharedInstance?.ISOStringToDate(dateString)
            events.append((date!, parsedEvents))
        }
        
        self.events = events
    }
}

final class DataManager {
    
    // MARK: - Variables & Constants
    
    /// Singleton instance
    static let sharedInstance = DataManager()
    
    /// Date Formatter instance
    let dateFormatter = DateFormatter()
    
    /// Calendar instance
    let calendar = Calendar(identifier: .gregorian)
    
    /// Weekdays instance
    let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    // Month instance
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    // MARK: - Private Methods
    
    /// Returns the appropriate suffix for a date
    /// - Parameters:
    ///     - day: The day of the month.
    func prefixForDayOfMonth(_ day: Int) -> String {
        if (day >= 10 && day <= 20) {
            return "th"
        }
        switch day % 10 {
        case 1:
            return "st"
        case 2:
            return "nd"
        case 3:
            return "rd"
        default:
            return "th"
        }
    }
    
    /// Attempts to convert an ISO-8601 millisecond based
    /// dateTime string to a Swift Date instance.
    ///
    /// - Parameters:
    ///     - string: The ISO-8601 date string.
    func ISOStringToDate(_ string: String?) -> Date? {
        return (string == nil) ? nil : dateFormatter.date(from: string!)
    }
    
    // MARK: - Public Methods
    
    /// Attempts to deserialize and return an EventPacket object for JSON
    /// obtained from a server request.
    ///
    /// - Parameters:
    ///     - data: The JSON encoded data.
    func parseDataToEventPacket(data: Data?) -> EventPacket? {
        if (data == nil) {
            return nil
        }
        
        guard
            let json = try? JSONSerialization.jsonObject(with: data!, options: []),
            let dictionary: [String: Any] = json as? [String: Any],
            let eventString: String = dictionary["data"] as? String,
            let eventData: Data = eventString.data(using: String.Encoding.utf8),
            let eventjson = try? JSONSerialization.jsonObject(with: eventData, options: []),
            let eventPacket: EventPacket = EventPacket.init(json: eventjson as! [[Any]])
            else {
                return nil
        }
        
        return eventPacket
    }
    
    required init? () {
        // Set date format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
}
