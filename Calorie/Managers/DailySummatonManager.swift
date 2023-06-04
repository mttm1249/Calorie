//
//  DailySummatonManager.swift
//  Calorie
//
//  Created by mttm on 03.06.2023.
//

import Foundation

class DailySummationManager {
    private var recordManager: RecordManager
    private var timer: Timer?
    private let dateManager: DateManager

    init(recordManager: RecordManager) {
        self.recordManager = recordManager
        self.dateManager = DateManager()
        scheduleSummation()
    }
    
    private func scheduleSummation() {
        let secondsUntilMidnight = dateManager.secondsUntilMidnight()
        timer = Timer.scheduledTimer(withTimeInterval: secondsUntilMidnight, repeats: false) { [weak self] _ in
            self?.saveMissingDailyTotals()
            self?.scheduleSummation()
        }
    }
    
    private func saveMissingDailyTotals() {
        let allDailyTotals = recordManager.fetchAllDailyTotalsFromCoreData()
        
        var dateToCheck = dateManager.previousMidnight(from: Date())
        while allDailyTotals.contains(where: { dateManager.isSameDay(date1: $0.date, date2: dateToCheck) }) == false {
            saveDailyCalorieSummation(for: dateToCheck)
            dateToCheck = dateManager.previousMidnight(from: dateToCheck)
        }
    }
    
    private func saveDailyCalorieSummation(for date: Date) {
        let recordsForDate = recordManager.fetchRecordsFromCoreData().filter { dateManager.isSameDay(date1: $0.createDate, date2: date) }
        let dailySum = recordsForDate.reduce(0) { $0 + (Int($1.calorieValueInfo) ?? 0) }
        let dailySumRecord = DailyTotalModel(date: date, totalCaloriesinfo: dailySum)
        recordManager.saveDailyTotalToCoreData(dailyTotal: dailySumRecord)
    }
    
    deinit {
        timer?.invalidate()
    }
}
