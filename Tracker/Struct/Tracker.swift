//
//  Tracker.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 03.05.2023.
//

import UIKit

struct Tracker: Hashable {
    let id: UUID
    let name: String
    let color: UIColor?
    let emoji: String?
    let schedule: [WeekDay]?
}
