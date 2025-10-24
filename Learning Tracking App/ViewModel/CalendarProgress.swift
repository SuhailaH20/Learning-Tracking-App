//
//  CalendarProgressViewModel.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 29/04/1447 AH.
//

import SwiftUI

@Observable
class CalendarHorizontalViewModel {
    // MARK: - Published Properties
    var currentDate = Date()
    var date = Date()
    var showingDatePicker = false

    var selectedMonth: Int
    var selectedYear: Int

    let learnedDates: [Date]
    let frozenDates: [Date]

    // MARK: - Init
    init(learnedDates: [Date], frozenDates: [Date]) {
        self.learnedDates = learnedDates
        self.frozenDates = frozenDates

        let now = Date()
        let calendar = Calendar.current
        selectedMonth = calendar.component(.month, from: now) - 1
        selectedYear = calendar.component(.year, from: now)
    }

    // MARK: - Computed Properties
    var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }

    var weekDays: [String] {
        let formatter = DateFormatter()
        return formatter.shortWeekdaySymbols
    }

    var weekDates: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    // MARK: - Methods
    func moveMonth(_ value: Int) {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: value, to: currentDate) {
            currentDate = newDate
        }
    }

    func firstDayOfMonth(for date: Date) -> Date {
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: comps) ?? date
    }

    func applyMonthYearSelection() {
        var comps = DateComponents()
        comps.year = selectedYear
        comps.month = selectedMonth + 1
        comps.day = 1
        if let composed = Calendar.current.date(from: comps) {
            currentDate = composed
        }
    }

    func statusForDate(_ date: Date) -> DayStatus {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return .current
        } else if learnedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
            return .learned
        } else if frozenDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
            return .frozen
        } else {
            return .normal
        }
    }

    func backgroundColor(for status: DayStatus) -> Color {
        switch status {
        case .current: return Color.orange
        case .learned: return Color.orange.opacity(0.2)
        case .frozen:  return Color.coldBlue
        case .normal:  return Color.clear
        }
    }

    func textColor(for status: DayStatus) -> Color {
        switch status {
        case .current: return .white
        case .learned: return .orange
        case .frozen:  return .cyan
        case .normal:  return .white
        }
    }
}
