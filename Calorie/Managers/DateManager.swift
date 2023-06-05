//
//  DateManager.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import Foundation

class DateManager {
    
    private let calendar = Calendar.current

    func secondsUntilMidnight() -> TimeInterval {
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        if let midnight = calendar.date(from: components)?.addingTimeInterval(24*60*60) {
            let secondsUntilMidnight = midnight.timeIntervalSince(now)
            return secondsUntilMidnight
        }
        return 0
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        return calendar.isDate(date1, inSameDayAs: date2)
    }

    func previousMidnight(from date: Date) -> Date {
        if let midnightOfDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date) {
            return calendar.date(byAdding: .day, value: -1, to: midnightOfDate) ?? date
        }
        return date
    }
}
