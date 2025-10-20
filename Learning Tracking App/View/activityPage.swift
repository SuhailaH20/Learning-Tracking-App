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
            Spacer().frame(height: 24)

            
            Learnedbutton()
            Spacer().frame(height: 32)

            
            Freezedbutton()
            Text("1 out of 2 Freezes used")
                    .font(Font.system(size: 14))
                    .foregroundStyle(Color.secondary)
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
        GlassEffectContainer{
            VStack(spacing: 16) {
                // Title
                HStack {
                    //Top part month and year
                    Text("October 2025")
                        .font(.system(size: 17, weight: .semibold))
                    Image(systemName: "chevron.right").foregroundStyle(Color.orange).bold()
                    
                    //sketch styling:
//                        .font(.system(size: 13, weight: .bold))
//                        .foregroundStyle(Color.orange)
                    
                    Spacer()
                    Image(systemName: "chevron.left").foregroundStyle(Color.orange).bold()
                        .padding(.trailing,20)
                    Image(systemName: "chevron.right").foregroundStyle(Color.orange).bold()
                    
                    
                }
                
                // Weekday headers
                HStack {
                    ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                        Text(day)
                            .font(.system(size: 13, weight: .semibold))
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
                            .frame(width: 44, height: 44)
                            .glassEffect()
                            .overlay(
                                Text("\(date)")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor((20...24).contains(date) ? .white : .primary)
                            )
                            .frame(maxWidth: .infinity)
                    }
                }
                Divider()
                // Progress section
                VStack(spacing: 12) {
                    Text("Learning Swift")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 12) {
                        
                        // Learned box
                        ZStack{
                            Rectangle()
                                .frame(width: 160, height: 70)
                                .background(Color.brownie)
                                .cornerRadius(34)
                                .opacity(0.8)
                                .glassEffect()
                           
                        HStack {
                            Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                            .font(.system(size: 15, weight: .bold))
                            
                            VStack(alignment:.leading){
                                Text("3")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("Days Learned")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12, weight: .regular))
                                
                            }
                            
                        }
                        }

                        
                        // Frozen box
                        ZStack{
                            Rectangle()
                                .frame(width: 160, height: 70)
                                .background(Color.coldBlue)
                                .cornerRadius(34)
                                .glassEffect()
                           
                        HStack {
                            Image(systemName: "cube.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 15, weight: .bold))
                            
                            VStack(alignment:.leading){
                                Text("1")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("Day Frozen")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12, weight: .regular))

                            }
                  
                        }
                        }
                    
                        
                     
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .glassEffect(.clear,in:.rect(cornerRadius: 20))
        }
    }
    
}

//Log as Learned button
struct Learnedbutton : View{
    var body: some View{
        Button("Log as Learned") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .bold()
        .foregroundStyle(Color.white)
        .font(.system(size: 36))
        .padding(100)
        .background(
            Circle()
                .fill(Color.richOrange.opacity(0.95))
                .overlay(
                    Circle()
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
                )
              .glassEffect()
              .glassEffect(.clear.interactive())

        )
    }
}

//Log as freezed
struct Freezedbutton : View{
    var body: some View{
        Button("Log as Freezed") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .foregroundStyle(Color.white)
        .font(.system(size: 17))
        .frame(width: 274,height:48)
        .glassEffect(.regular.tint(Color.lightBlue.opacity(0.65)).interactive())
              
    }
}




#Preview {
    activityPage()
}
