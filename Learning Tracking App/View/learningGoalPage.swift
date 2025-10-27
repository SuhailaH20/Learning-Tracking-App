//
//  learningGoalPage.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 28/04/1447 AH.
//

import SwiftUI

struct LearningGoalView: View {
    @StateObject private var viewModel = InputSectionViewModel()
    
    @State private var showAlert = false
    @State private var navigateToActivity = false
    
    // Store the data to pass to activityPage
    @State private var activityTopic: String = ""
    @State private var activityProgress: LearningProgress = LearningProgress(daysLearned: 0, daysFrozen: 0)

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Spacer().frame(height: 32)
                
                InputSection(viewModel: viewModel)
                    .padding(.horizontal)
                
                Spacer()
                
                }
            }
            .navigationTitle("Learning Goal")
            .bold()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EmptyView()

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                }
            }
            .alert("Confirm", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Yes", role: .destructive) {
                    // Prepare data for activityPage
                    activityTopic = viewModel.topic
                    activityProgress = LearningProgress(
                        daysLearned: 0,
                        daysFrozen: viewModel.freezeLimit
                    )
                    
                    // Optional: reset inputs
                    viewModel.topic = ""
                    viewModel.selectedTimeframe = "Week"
                    
                    // Navigate
                    navigateToActivity = true
                }
            } message: {
                Text("Are you sure you want to proceed?")
            }
            
            .navigationDestination(isPresented: $navigateToActivity) {
                activityPage(
                    topic: activityTopic,
                    learningProgress: activityProgress
                )
                .navigationBarBackButtonHidden(true) // no back button on the next page either
            }
        }
    }


#Preview {
    LearningGoalView()
}
