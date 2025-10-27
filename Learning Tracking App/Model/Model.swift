//
//  Model.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 29/04/1447 AH.
//
import Foundation

struct LearningProgress: Codable {
    var daysLearned: Int
    var daysFrozen: Int
    var learnedDates: [Date] = []
    var frozenDates: [Date] = []
}


//For the buttons
enum ActivityState {
    case idle
    case learnedToday
    case dayFrozen
    case goalCompleted
}

// for the progress calender
enum DayStatus {
    case current
    case learned
    case frozen
    case normal

}
