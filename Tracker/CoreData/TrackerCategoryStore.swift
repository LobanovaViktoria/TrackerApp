//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 18.05.2023.
//

import Foundation
import CoreData

class TrackerCategoryStore {
    
    static let shared = TrackerCategoryStore()
    
    private let context: NSManagedObjectContext
    
    convenience init() {
        let context = DatabaseManager.shared.context
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }

func addNewTrackerCategory(_ trackerCategory: TrackerCategory) throws {
        let trackerCategoryCoreData = TrackerCategoryCoreData(context: context)
        updateExistingTrackerCategory(trackerCategoryCoreData, with: trackerCategory)
        try context.save()
    }
    
    func updateExistingTrackerCategory(_ trackerCategoryCoreData: TrackerCategoryCoreData, with category: TrackerCategory) {
        trackerCategoryCoreData.name = category.name
        trackerCategoryCoreData.addToTrackers(Set(category.trackers) as? NSSet ?? [])
    }
    
    func fetchTrackerCategories() throws -> [TrackerCategory] {
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
        let trackerCategoriesFromCoreData = try context.fetch(fetchRequest)
        return try trackerCategoriesFromCoreData.map { try self.trackerCategory(from: $0) }
    }
    
     func trackerCategory(from data: TrackerCategoryCoreData) throws -> TrackerCategory {
         guard let name = data.name else {
             throw DatabaseError.someError
         }
         guard let trackers = data.trackers else {
             throw DatabaseError.someError
         }
         return TrackerCategory(
             name: name,
             trackers: Array(_immutableCocoaArray: trackers)
         )
     }
    
}
