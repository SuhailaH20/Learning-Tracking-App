//
//  ActionLogger.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 29/04/1447 AH.
//

import SwiftUI
import Combine

@MainActor
final class ActivityPageViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var activityState: ActivityState = .idle
    @Published var daysLearned: Int = 0
    @Published var freezesUsed: Int = 0
    @Published var isFreezeDisabled: Bool = false
    @Published var learnedDates: [Date] = []
    @Published var frozenDates: [Date] = []

    let learningProgress: LearningProgress

    // MARK: - Init
    init(learningProgress: LearningProgress) {
        self.learningProgress = learningProgress
    }

    // MARK: - Logic
    func logAsLearned() {
        daysLearned += 1
        learnedDates.append(Date())
        print("From the calender modelview Learned dates count: \(learnedDates.count)")

        // Check if goal completed
        if daysLearned >= learningProgress.daysFrozen {
            activityState = .goalCompleted
        } else {
            activityState = .learnedToday
            isFreezeDisabled = true

            // Reset after 1 min (for testing; adjust as needed)
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                self.activityState = .idle
                self.isFreezeDisabled = false
            }
        }
    }

    func freezeDay() {
        guard !isFreezeDisabled else { return }
        guard freezesUsed < learningProgress.daysFrozen else { return }

        freezesUsed += 1
        frozenDates.append(Date())
        isFreezeDisabled = true
        activityState = .dayFrozen

        // Reset after 1 min
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.isFreezeDisabled = false
            self.activityState = .idle
        }
    }
}
