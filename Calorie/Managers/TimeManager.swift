//
//  TimeManager.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import Foundation

class TimeManager {
    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
