//
//  CalendarProgressViewModel.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 29/04/1447 AH.
//

import Foundation
import SwiftUI
import Combine

class CalendarProgressViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var showPicker: Bool = false

    // Static for now, but this can be dynamic based on actual data
    @Published var progress = LearningProgress(daysLearned: 3, daysFrozen: 1)

    var weekDates: [Date] {
        let calendar = Calendar.current
        let today = selectedDate

        // Get Sunday of the week
        let weekday = calendar.component(.weekday, from: today)
        let daysFromSunday = weekday - 1

        guard let sunday = calendar.date(byAdding: .day, value: -daysFromSunday, to: today) else {
            return []
        }

        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: sunday)
        }
    }

    func adjustWeek(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: value, to: selectedDate) {
            selectedDate = newDate
        }
    }
}
