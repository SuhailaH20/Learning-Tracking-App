//
//  activityPage.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 26/04/1447 AH.
//

import SwiftUI

struct activityPage: View {
    var body: some View {
        VStack{
           Toolbar()
            
            CalendarProgressCard()
        }
        
        .padding(16)
    }
}



struct Toolbar: View {
    var body: some View {
        HStack{
            Text("Activity")
                .font(.system(size: 34, weight: .bold))
            Spacer()
            
            ZStack{
                Circle()
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    .blur(radius: 1)
                    .glassEffect()
                    .frame(width: 44, height: 44)
                
                Image(systemName: "calendar")
                    .font(.system(size: 17, weight: .bold))
            }
            
            ZStack{
                Circle()
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    .blur(radius: 1)
                    .glassEffect()
                    .frame(width: 44, height: 44)
                
                Image(systemName: "pencil.and.outline")
                    .font(.system(size: 17, weight: .bold))
            }

        }
    }
}


struct CalendarProgressCard: View {
    var body: some View {
        VStack(spacing: 16) {
            // Title
            Text("October 2025")
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            // Weekday headers
            HStack {
                ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }

            // Dates row
            HStack {
                ForEach(20...26, id: \.self) { date in
                    Circle()
                        .fill(date == 24 ? Color.orange :
                              (20...23).contains(date) ? Color.brown :
                              Color.clear)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text("\(date)")
                                .font(.system(size: 14))
                                .foregroundColor((20...24).contains(date) ? .white : .primary)
                        )
                        .frame(maxWidth: .infinity)
                }
            }
Divider()
            // Progress section
            VStack(spacing: 12) {
                Text("Learning Swift")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 12) {
                    // Learned box
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.white)
                        Text("3 Days Learned")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding()
                    .background(Color.richOrange)
                    .cornerRadius(12)

                    // Frozen box
                    HStack {
                        Image(systemName: "cube.fill")
                            .foregroundColor(.white)
                        Text("1 Day Frozen")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
    }
}




#Preview {
    activityPage()
}
