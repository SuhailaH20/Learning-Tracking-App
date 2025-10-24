//
//  Model.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 29/04/1447 AH.
//

struct LearningProgress {
    var daysLearned: Int
    var daysFrozen: Int
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
