//
//  DailySummatonManager.swift
//  Calorie
//
//  Created by mttm on 03.06.2023.
//

import Foundation

class DailySummationManager {
    private let recordManager: RecordManager
    private let dateManager: DateManager
    
    init(recordManager: RecordManager) {
        self.recordManager = recordManager
        self.dateManager = DateManager()
    }
    
    func saveMissingRecordsIfNeeded() {
        let currentDate = Date()
        let allRecords = recordManager.fetchRecordsFromCoreData()
        
        let sortedRecords = allRecords.sorted { $0.createDate > $1.createDate }
        
        guard let lastRecordDate = sortedRecords.first?.createDate else { return }
        if dateManager.isSameDay(date1: lastRecordDate, date2: currentDate) { return }
        
        let lastRecords = allRecords.filter { dateManager.isSameDay(date1: $0.createDate, date2: lastRecordDate) }
        let totalCalories = lastRecords.compactMap { Int($0.calorieValueInfo) }.reduce(0, +)
        
        let dailyTotalRecords = recordManager.fetchAllDailyTotalsFromCoreData()
        let sortedDailyTotalRecords = dailyTotalRecords.sorted { $0.date > $1.date }
        
        if let lastDailyTotalRecordDate = sortedDailyTotalRecords.first?.date, dateManager.isSameDay(date1: lastRecordDate, date2: lastDailyTotalRecordDate) { return }
        
        let dailySumRecord = DailyTotalModel(date: lastRecordDate, totalCaloriesinfo: totalCalories)
        
        recordManager.saveDailyTotalToCoreData(dailyTotal: dailySumRecord)
    }
    
    func fetchAllDailyTotals() -> [DailyTotalModel] {
        return recordManager.fetchAllDailyTotalsFromCoreData()
    }
}
