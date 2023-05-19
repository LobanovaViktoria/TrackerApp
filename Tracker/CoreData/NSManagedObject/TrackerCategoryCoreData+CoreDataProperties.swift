//
//  TrackerCategoryCoreData+CoreDataProperties.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 19.05.2023.
//
//

import Foundation
import CoreData


extension TrackerCategoryCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerCategoryCoreData> {
        return NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
    }

    @NSManaged public var name: String?
    @NSManaged public var trackers: NSSet?

    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    
    public var trackersArray: [TrackerCoreData] {
        let trackerSet = trackers as? Set<TrackerCoreData> ?? []
        return trackerSet.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
        }
    }


// MARK: Generated accessors for trackers
extension TrackerCategoryCoreData {

    @objc(addTrackersObject:)
    @NSManaged public func addToTrackers(_ value: TrackerCoreData)

    @objc(removeTrackersObject:)
    @NSManaged public func removeFromTrackers(_ value: TrackerCoreData)

    @objc(addTrackers:)
    @NSManaged public func addToTrackers(_ values: NSSet)
    
    @objc(removeTrackers:)
    @NSManaged public func removeFromTrackers(_ values: NSSet)

}

extension TrackerCategoryCoreData : Identifiable {

}
