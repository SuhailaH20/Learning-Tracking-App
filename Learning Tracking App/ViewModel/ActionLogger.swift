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
    @Published var learningProgress: LearningProgress

    @Published var activityState: ActivityState = .idle
    @Published var isFreezeDisabled: Bool = false

    // Convenience computed properties (no longer separate arrays)
    var daysLearned: Int = 10/*{ learningProgress.learnedDates.count }*/
    var freezesUsed: Int { learningProgress.frozenDates.count }

    var learnedDates: [Date] { learningProgress.learnedDates }
    var frozenDates: [Date] { learningProgress.frozenDates }

    // MARK: - Init
    init(learningProgress: LearningProgress) {
        self.learningProgress = learningProgress
    }

    // MARK: - Logic
    func logAsLearned() {
        let today = Date()
        learningProgress.learnedDates.append(today)

        if daysLearned >= learningProgress.daysFrozen {
            activityState = .goalCompleted
        } else {
            activityState = .learnedToday
            isFreezeDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                self.activityState = .idle
                self.isFreezeDisabled = false
            }
        }

        saveProgress()
    }

    func freezeDay() {
        guard !isFreezeDisabled else { return }
        guard freezesUsed < learningProgress.daysFrozen else { return }

        learningProgress.frozenDates.append(Date())
        isFreezeDisabled = true
        activityState = .dayFrozen

        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.isFreezeDisabled = false
            self.activityState = .idle
        }

        saveProgress()
    }

    // MARK: - Persistence
    private func saveProgress() {
        if let data = try? JSONEncoder().encode(learningProgress) {
            UserDefaults.standard.set(data, forKey: "LearningProgress_\(UUID().uuidString)")
        }
    }
}
