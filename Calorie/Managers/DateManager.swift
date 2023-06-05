//
//  DateManager.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import Foundation

class DateManager {
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        return components1.year == components2.year && components1.month == components2.month && components1.day == components2.day
    }
}
