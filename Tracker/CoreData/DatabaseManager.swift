//
//  DatabaseManager.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 18.05.2023.
//

import Foundation
import CoreData

enum DatabaseError: Error {
    case someError
}

final class DatabaseManager {
    
    private let modelName = "Tracker"
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    init() {
        _ = persistentContainer
    }
    
    static let shared = DatabaseManager()
    
    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchTrackerCategories() throws -> [TrackerCategory] {
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
        let trackerCategoriesFromCoreData = try context.fetch(fetchRequest)
        return try trackerCategoriesFromCoreData.map { try self.trackerCategory(from: $0) }
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
