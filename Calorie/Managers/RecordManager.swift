//
//  RecordManager.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import Foundation
import CoreData

class RecordManager {
    
    private let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
    
    func saveRecordToCoreData(record: RecordModel) {
        let recordEntity = RecordEntity(context: context)
        recordEntity.createDate = record.createDate
        recordEntity.calorieValueInfo = record.calorieValueInfo
        do {
            try context.save()
        } catch let error {
            print("Failed to save Record: \(error)")
        }
    }
    
    func fetchRecordsFromCoreData() -> [RecordModel] {
        let fetchRequest = NSFetchRequest<RecordEntity>(entityName: "RecordEntity")
        do {
            let fetchedEntities = try context.fetch(fetchRequest)
            return fetchedEntities.map { RecordModel(createDate: $0.createDate!, calorieValueInfo: $0.calorieValueInfo!) }
        } catch {
            print("Failed to fetch records: \(error)")
            return []
        }
    }
}
