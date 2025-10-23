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
           CurrentNavigation()
            Spacer().frame(height: 24)
            //Card
            CurrentCard()
            
            Spacer().frame(height: 32)

            //BUTTON LOG AS LEARNED
          //  LearnedBIGbutton()
            LearnedTodayBIGbutton()
           //DayFreezedBIGbutton()
           // WellDone()
            
            
            Spacer().frame(height: 32)

            // BUTTON LOG AS FREEZED
            Freezedbutton()
            //FreezedbuttonOFF()
            //SetlearningGoal()
            
            Text("1 out of 2 Freezes used")
                .font(Font.system(size: 14))
                .foregroundStyle(Color.gray)
            
            
//            Text("Set same learning goal and duration").foregroundStyle(Color.orange).padding(8)

        }
    }
}


//Log as Learned button
struct LearnedBIGbutton : View{
    var body: some View{
        Button("Log as\nLearned") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .bold()
        .foregroundStyle(Color.white)
        .font(.system(size: 36))
        .frame(width:274,height:274)
        .background(
            Circle()
                .fill(Color.richOrange.opacity(0.95))
                .glassEffect(.clear.interactive())

        )
    }
}

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
        .padding(100)
        .background(
            Circle()
                .fill(Color.coldBlue.opacity(0.95))
                .glassEffect(.clear.interactive())

        )
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
//Log as freezed OFF
struct FreezedbuttonOFF : View{
    var body: some View{
        Button("Log as Freezed") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .foregroundStyle(Color.white)
        .font(.system(size: 17))
        .frame(width: 274,height:48)
        .glassEffect(.regular.tint(Color.coldBlue.opacity(0.4)).interactive())
              
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
    activityPage().preferredColorScheme(.dark)
}
