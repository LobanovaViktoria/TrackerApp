//
//  Date+Extentions.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 11.05.2023.
//

import Foundation

extension Date {
    var yearMonthDayComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day], from: self)
    }
}
