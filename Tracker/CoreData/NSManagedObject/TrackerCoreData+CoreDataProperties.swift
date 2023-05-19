//
//  TrackerCoreData+CoreDataProperties.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 19.05.2023.
//
//

import Foundation
import CoreData


extension TrackerCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerCoreData> {
        return NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
    }

    @NSManaged public var color: String?
    @NSManaged public var emoji: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var schedule: [String]?
    @NSManaged public var category: TrackerCategoryCoreData?
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
}

extension TrackerCoreData : Identifiable {

}
