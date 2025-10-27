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

    // Convenience computed properties
    var daysLearned: Int { learningProgress.learnedDates.count }
    var freezesUsed: Int { learningProgress.frozenDates.count }

    var learnedDates: [Date] { learningProgress.learnedDates }
    var frozenDates: [Date] { learningProgress.frozenDates }

    // MARK: - Private Properties
    private var lastActionDate: Date?
    private var inactivityTimer: Timer?

    // MARK: - Init
    init(learningProgress: LearningProgress) {
        self.learningProgress = learningProgress
        startInactivityTimer()
    }

    // MARK: - Logic
    func logAsLearned() {
        let today = Date()
        learningProgress.learnedDates.append(today)
        lastActionDate = today
        resetInactivityTimer()

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
        lastActionDate = Date()
        resetInactivityTimer()

        isFreezeDisabled = true
        activityState = .dayFrozen

        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.isFreezeDisabled = false
            self.activityState = .idle
        }

        saveProgress()
    }

    // MARK: - Inactivity Tracking
    private func startInactivityTimer() {
        inactivityTimer?.invalidate()
        inactivityTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            self?.checkForInactivity()
        }
    }

    private func resetInactivityTimer() {
        lastActionDate = Date()
    }

    private func checkForInactivity() {
        guard let lastActionDate = lastActionDate else {
            self.lastActionDate = Date()
            return
        }

        // For testing: 2 minutes instead of 32 hours
        let timeSinceLastAction = Date().timeIntervalSince(lastActionDate)
        if timeSinceLastAction > 120 { // 120 seconds = 2 minutes
            resetStreak()
        }
    }

    private func resetStreak() {
        learningProgress.learnedDates.removeAll()
        learningProgress.frozenDates.removeAll()
        activityState = .idle
        isFreezeDisabled = false
        saveProgress()
        print("🔥 Streak has been reset due to inactivity.")
    }

    // MARK: - Persistence
    private func saveProgress() {
        if let data = try? JSONEncoder().encode(learningProgress) {
            UserDefaults.standard.set(data, forKey: "LearningProgress_\(UUID().uuidString)")
        }
    }
}
