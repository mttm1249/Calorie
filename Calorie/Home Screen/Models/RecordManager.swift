//
//  RecordManager.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import Foundation
import CoreData

class RecordManager {
    static func saveRecordToCoreData(record: Record, context: NSManagedObjectContext) {
        let recordEntity = RecordEntity(context: context)
        recordEntity.name = record.name
        recordEntity.date = record.date
        recordEntity.descriptionInfo = record.descriptionInfo
        
        do {
            try context.save()
        } catch let error {
            print("Failed to save Record: \(error)")
        }
    }
}
