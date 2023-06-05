//
//  DateManager.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import Foundation

class DateManager {
    
    private let calendar = Calendar.current
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}
