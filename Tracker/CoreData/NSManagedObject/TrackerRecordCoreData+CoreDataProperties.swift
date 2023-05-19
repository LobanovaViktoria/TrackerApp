//
//  TrackerRecordCoreData+CoreDataProperties.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 19.05.2023.
//
//

import Foundation
import CoreData


extension TrackerRecordCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerRecordCoreData> {
        return NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var idTracker: UUID?

}

extension TrackerRecordCoreData : Identifiable {

}
