//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 18.05.2023.
//

import Foundation
import CoreData

class TrackerRecordStore {
    
    private let context: NSManagedObjectContext
    
    convenience init() {
        let context = DatabaseManager.shared.context
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
