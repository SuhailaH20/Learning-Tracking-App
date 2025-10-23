//
//  activityPage.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 26/04/1447 AH.
//

import SwiftUI

enum ActivityState {
    case idle
    case learnedToday
    case dayFrozen
    case goalCompleted
}


struct activityPage: View {
    @State private var activityState: ActivityState = .idle
    @State private var daysLearned: Int = 5
    @State private var freezesUsed: Int = 0
    @State private var isFreezeDisabled: Bool = false
    @State private var learnedDates: [Date] = []
    @State private var frozenDates: [Date] = []

    var learningProgress: LearningProgress

    var body: some View {
        VStack {
            CurrentNavigation()
            Spacer().frame(height: 24)
            CurrentCard(freezesUsed: freezesUsed, daysLearned: daysLearned, learnedDates: learnedDates, frozenDates: frozenDates)
            Spacer().frame(height: 32)

            // MARK: - Main "Learned" Button
            Group {
                switch activityState {
                case .idle:
                    LearnedBIGbutton {
                        logAsLearned()
                    }

                case .learnedToday:
                    LearnedTodayBIGbutton()
                        .disabled(true)

                case .dayFrozen:
                    DayFreezedBIGbutton()
                        .disabled(true)

                case .goalCompleted:
                    WellDone()
                }
            }

            Spacer().frame(height: 32)

            // MARK: - Freeze Button Section
            switch activityState {
            case .goalCompleted:
                // Replace with "Set new goal" button
                SetlearningGoal()
            default:
                // Normal freeze button behavior
                if isFreezeDisabled {
                    FreezedbuttonOFF()
                        .disabled(true)
                } else {
                    Freezedbutton {
                        freezeDay()
                    }
                }
            }

            // MARK: - Bottom Text Section
            switch activityState {
            case .goalCompleted:
                Text("Set same learning goal and duration")
                    .foregroundStyle(Color.orange)
                    .font(.system(size: 16))
                    .padding(.top, 8)
            default:
                Text("\(freezesUsed) out of \(learningProgress.daysFrozen) Freezes used")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(.top, 8)
            }
        }
    }

    // MARK: - Functions
    private func logAsLearned() {
        daysLearned += 1
        learnedDates.append(Date())
        // Check if the goal is completed
        if daysLearned >= learningProgress.daysFrozen {
            activityState = .goalCompleted
        } else {
            // Temporary learned today state
            activityState = .learnedToday
            isFreezeDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                activityState = .idle
                isFreezeDisabled = false

            }
        }
    }

    private func freezeDay() {
        guard !isFreezeDisabled else { return }
        guard freezesUsed < learningProgress.daysFrozen else { return }

        freezesUsed += 1
        frozenDates.append(Date())
        isFreezeDisabled = true
        activityState = .dayFrozen

        // Re-enable after 1 minute
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            isFreezeDisabled = false
            activityState = .idle
        }
    }
}



//Log as Learned button
struct LearnedBIGbutton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Log as\nLearned")
                .bold()
                .foregroundStyle(Color.white)
                .font(.system(size: 36))
                .frame(width: 274, height: 274)
                .background(
                    Circle()
                        .fill(Color.richOrange.opacity(0.95))
                        .glassEffect(.clear.interactive())
                )
        }
    }
}

struct Freezedbutton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Log as Freezed")
                .foregroundStyle(Color.white)
                .font(.system(size: 17))
                .frame(width: 274, height: 48)
                .glassEffect(.regular.tint(Color.lightBlue.opacity(0.65)).interactive())
        }
    }
}

struct FreezedbuttonOFF: View {
    var body: some View {
        Button("Log as Freezed") {}
            .foregroundStyle(Color.white)
            .font(.system(size: 17))
            .frame(width: 274, height: 48)
            .glassEffect(.regular.tint(Color.coldBlue.opacity(0.4)).interactive())
    }
}


//----------- WELL DONE GOAL COMPLETED----------

struct WellDone: View{
    var body: some View{
        VStack(alignment:.center){
            
            Image(systemName: "hands.and.sparkles.fill").foregroundStyle(Color.orange)
                .font(Font.system(size: 40))
                .padding(1)
            
            Text("Well Done!")
                .bold()
                .font(Font.system(size: 22))
            Spacer().frame(height: 4)
            Text("Goal completed! start learning again or set new learning goal")
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .foregroundStyle(Color.gray)
                .font(Font.system(size: 18))
                .fontWeight(.medium)
        }
            .padding(24)
    }
}
        // ---------SMALL BUTTON---------

//Learned today button
struct LearnedTodayBIGbutton : View{
    var body: some View{
        Button("Learned Today") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .bold()
        .foregroundStyle(Color.orange)
        .font(.system(size: 38))
        .frame(width:274,height:274)
        .background(
            Circle()
                .fill(Color.richOrange.opacity(0.3))
                .glassEffect(.clear.interactive())

        )
    }
}

//Day freezed button
struct DayFreezedBIGbutton : View{
    var body: some View{
        Button("Day Freezed") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .bold()
        .foregroundStyle(Color.lightBlue)
        .font(.system(size: 38))
        .frame(width:274,height:274)
        .background(
            Circle()
                .fill(Color.coldBlue.opacity(0.95))
                .glassEffect(.clear.interactive())

        )
    }
}

//Set a new learning goal
struct SetlearningGoal: View {
    var body: some View{
        Button("Set new learning goal") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .foregroundStyle(Color.white)
        .font(.system(size: 17))
        .frame(width: 274,height:48)
        .glassEffect(.regular.tint(Color.orange.opacity(0.95)).interactive())
              
    }
}

#Preview {
activityPage(
    learningProgress: LearningProgress(daysLearned: 8, daysFrozen: 8)
)
}
