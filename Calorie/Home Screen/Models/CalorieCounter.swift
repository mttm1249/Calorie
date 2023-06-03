//
//  CalorieCounter.swift
//  Calorie
//
//  Created by mttm on 03.06.2023.
//

import Foundation

class CalorieCounter {
    private var records: [RecordModel] = []
    private let recordManager: RecordManager

    var totalCalories: Int {
        return records.compactMap { Int($0.calorieValueInfo) }.reduce(0, +)
    }

    init(recordManager: RecordManager) {
        self.recordManager = recordManager
        updateRecords()
    }

    func updateRecords() {
        self.records = recordManager.fetchRecordsFromCoreData()
    }

    func addRecord(_ record: RecordModel) {
        recordManager.saveRecordToCoreData(record: record)
        updateRecords()
    }

    func showTotalCalories() -> String {
        return "Total: \(totalCalories) kkal"
    }
}
