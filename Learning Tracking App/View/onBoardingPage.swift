//
//  ContentView.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 24/04/1447 AH.
//

import SwiftUI

struct onBoardingPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Logo
            Logo()
            
            // Greeting
            Greeting()

            // Input Section
            InputSection()
            


            // Spacer to push button down
            Spacer()

            // Start Button
            StartLearningButton {
                print("Start Learning tapped!")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, 24)
        //.padding(.vertical, 32)
    }
}

struct Logo: View {
    var body: some View {
        ZStack {
            Circle()
            //  .fill(Color.primary.opacity(0.1))
                .fill(Color.brownishOrange.opacity(0.3))
                .frame(width: 109, height: 109)
                .glassEffect()
                .overlay{
                    Circle()
                        .strokeBorder(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                    Color.orange.opacity(0.4),
                                    Color.orange.opacity(0.6),
                                    Color.orange.opacity(0.2),
                                    Color.yellow.opacity(0.9),
                                    Color.orange.opacity(0.2),
                                    Color.orange.opacity(0.4)
                                ]),
                                center: .center
                            ),  lineWidth: 1
                        )
                        .frame(width: 109, height: 109)
                        .foregroundStyle(Color.richOrange).opacity(0.1)
      
                        .glassEffect()
                }

            Image(systemName: "flame.fill")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(Color.orange)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom,47)
    }
}

struct Greeting: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Hello Learner")
                .font(.system(size: 34, weight: .bold))

            Text("This app will help you learn everyday!")
                .font(.system(size: 17))
                .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
        }
        .padding(.bottom,31)
    }
}

struct InputSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("I want to learn")
                .font(.system(size: 22))
            
            TextField("Swift", text: .constant(""))
                .textFieldStyle(.plain)
            Divider()
            
            
        }
        .padding(.bottom,24)
        
        
        VStack(alignment:.leading, spacing: 12){
            Text("I want to learn it in a")
                .font(.system(size: 22))
            
        }
        
        VStack(alignment:.leading){
            TimeFilterView()

        }
}
    
}

struct TimeFilterView: View {
    @State private var selected = "Week"

    var body: some View {
        HStack(spacing: 8) {
            button(title: "Week")
            button(title: "Month")
            button(title: "Year")
        }
    }

    private func button(title: String) -> some View {
        Button(action: {
            selected = title
        }) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 97, height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(selected == title ? Color.richOrange : Color.white.opacity(0.1))
                        .strokeBorder(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.4),
                                    Color.white.opacity(0.6),
                                    Color.black.opacity(0.2),
                                    Color.white.opacity(0.9),
                                    Color.black.opacity(0.2),
                                    Color.black.opacity(0.4)
                                ]),
                                center: .center
                            ),  lineWidth: 1
                        )
                        .glassEffect()
                )
        }
    }
}


struct StartLearningButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Start Learning")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 182, height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.richOrange)
                        .strokeBorder(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.4),
                                    Color.white.opacity(0.6),
                                    Color.black.opacity(0.2),
                                    Color.white.opacity(0.9),
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.4)
                                ]),
                                center: .center
                            ),  lineWidth: 1
                        )
                )
                .glassEffect()

        }
    }
}


#Preview {
    onBoardingPage()
}
