//
//  learningGoalPage.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 28/04/1447 AH.
//

import SwiftUI

struct LearningGoalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = InputSectionViewModel()


    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Spacer().frame(height: 32)
                InputSection(viewModel: viewModel).padding(.horizontal)
                Spacer()
                
            }
            
            .navigationTitle("Learning Goal")
            .bold()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        // WARNING THE ACTION IS TEMPERORARY
                        action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement:.navigationBarTrailing){
                    Button(
                        // WARNING THE ACTION IS TEMPERORARY
                        action: {
                        presentationMode.wrappedValue.dismiss()
                        })
                    {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)

                        
                        }
                }
            }
        }
    }
}


#Preview {
    LearningGoalView()
}
