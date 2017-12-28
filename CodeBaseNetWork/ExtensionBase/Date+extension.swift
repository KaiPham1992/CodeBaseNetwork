//
//  Date+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit


extension Date {
    func dateToString(format: KDateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.description
        return  dateFormatter.string(from: self)
    }
    
    var millisecondsSince1970: UInt64 {
        return UInt64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func isToDay() -> Bool {
        let calendar = NSCalendar.current
        return calendar.isDateInToday(self)
    }
    
    func isThisMonth() -> Bool {
        let calendar = NSCalendar.current
        let month = calendar.component(.month, from: self)
        let currentMonth = calendar.component(.month, from: Date())
        return month == currentMonth
    }
    
    func toLocalTime() -> Date {
        let timezone: NSTimeZone = NSTimeZone.local as NSTimeZone
        let seconds: TimeInterval = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func timeAgo() -> String {
        let currentDate = Date()//.toLocalTime()
        let different = Calendar.current.dateComponents([.year, .month, .weekday, .day, .hour, .minute, .second], from: self, to: currentDate)
        
        if let year = different.year {
            if year > 0 {
                return year == 1 ? "1 year ago" : "\(year) years ago"
            }
        }
        if let month = different.month {
            if month > 0 {
                return month == 1 ? "1 month ago" : "\(month) months ago"
            }
        }
        
        if let week = different.weekday {
            if week > 0 {
                return week == 1 ? "1 week ago" : "\(week) weeks ago"
            }
        }
        
        if let day = different.day {
            if day > 0 {
                return day == 1 ? "1 day ago" : "\(day) days ago"
            }
        }
        
        if let hour = different.hour {
            if hour > 0 {
                return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
            }
        }
        
        if let minute = different.minute {
            if minute > 0 {
                return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
            }
        }
        if let second = different.second {
            if second > 0 {
                return second == 1 ? "1 second ago" : "\(second) seconds ago"
            }
        }
        
        return "Just Now"
    }
}


// MARK: date format
enum KDateFormat: String {
    case ddMMMyyCommahhmma = "dd MMM yyyy, hh:mm a"
    case ddMMMyyyySpacehhmma = "dd MMM yyyy hh:mm a"
    case ddMMyyyyhhmmma = "dd MM yyyy hh:mm"
    case ddMMMyyyy = "dd MMM yyyy"
    case ddMMyyyy = "dd MM yyyy"
    case MMMMyyyy = "MMMM yyyy"
    case hhmma = "hh:mm a"
    
    var description: String {
        return self.rawValue
    }
}
