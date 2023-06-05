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
        
        guard let lastRecordDate = allRecords.last?.createDate else { return }
        if dateManager.isSameDay(date1: lastRecordDate, date2: currentDate) { return }
        
        let lastRecords = allRecords.filter { dateManager.isSameDay(date1: $0.createDate, date2: lastRecordDate) }
        let totalCalories = lastRecords.compactMap { Int($0.calorieValueInfo) }.reduce(0, +)

        let dailySumRecord = DailyTotalModel(date: lastRecordDate, totalCaloriesinfo: totalCalories)
       
        recordManager.saveDailyTotalToCoreData(dailyTotal: dailySumRecord)
    }
    
    func fetchAllDailyTotals() -> [DailyTotalModel] {
        return recordManager.fetchAllDailyTotalsFromCoreData()
    }
}
