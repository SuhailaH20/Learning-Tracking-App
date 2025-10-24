//
//  ActivityCard.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 01/05/1447 AH.
//
import SwiftUI

//Card Struct
struct CurrentCard: View {
    var topic: String
    var freezesUsed: Int
    var daysLearned: Int

    var learnedDates: [Date]
    var frozenDates: [Date]
    var body: some View {
        GlassEffectContainer {
            HStack {
                VStack (alignment:.leading) {
                    CalendarHorizontalView(
                        learnedDates: learnedDates,
                        frozenDates: frozenDates
                    )
                    Spacer().frame(height: 12)
                    Divider()
                    Spacer().frame(height: 11.5)
                    Text("Learning \(topic)")
                        .bold()
                        .padding(.horizontal)
                    Spacer().frame(height: 12)

                    HStack{
                        Spacer()
                        //Days learned
                        DaysLearned(daysLearned: daysLearned)
                        
                        Spacer().frame(width:13)

                        //Days freezed
                        
                        DaysFreezed(freezesUsed: freezesUsed)
                        Spacer()
                    }
                    Spacer().frame(height: 12)

                }
            }
            
        }
        
        .glassEffect(.clear,in:.rect(cornerRadius: 10))
    }
}

//Navigation bar
struct CurrentNavigation: View {
    var body: some View {
        HStack(spacing:10){
            Text("Activity").bold().font(Font.largeTitle)
            Spacer()
            NavigationLink (destination: ScrollingCalendarView()) {
                Image(systemName: "calendar")
                    .font(Font.system(size: 20))
                    .foregroundStyle(.white)
                    .frame(width:44 ,height: 44)
                    .glassEffect()
            }
                
            NavigationLink (destination: LearningGoalView()) {
                Image(systemName: "pencil.and.outline")
                    .font(Font.system(size: 20))
                    .foregroundStyle(.white)
                    .frame(width:44 ,height: 44)
                    .glassEffect()
            }
        }
    }
}


//Calendar Struct

struct CalendarHorizontalView: View {
    @State private var viewModel: CalendarHorizontalViewModel

    init(learnedDates: [Date], frozenDates: [Date]) {
        _viewModel = State(initialValue: CalendarHorizontalViewModel(
            learnedDates: learnedDates,
            frozenDates: frozenDates
        ))
    }

    var body: some View {
        VStack {
            // Month bar
            HStack {
                Text(viewModel.monthYear).bold()

                Button(action: {
                    let comps = Calendar.current.dateComponents([.year, .month], from: viewModel.currentDate)
                    viewModel.selectedMonth = (comps.month ?? 1) - 1
                    viewModel.selectedYear = comps.year ?? viewModel.selectedYear
                    viewModel.showingDatePicker = true
                }) {
                    Image(systemName: viewModel.showingDatePicker ? "chevron.down" : "chevron.right")
                        .foregroundColor(.orange)
                        .bold()
                }
                .popover(isPresented: $viewModel.showingDatePicker, arrowEdge: .top) {
                    VStack(spacing: 16) {
                        HStack(spacing: 0) {
                            // Month wheel
                            Picker("Month", selection: $viewModel.selectedMonth) {
                                ForEach(0..<12, id: \.self) { index in
                                    Text(DateFormatter().monthSymbols[index]).tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)

                            // Year wheel
                            let currentYear = Calendar.current.component(.year, from: Date())
                            let lowerBoundYear = 1900
                            Picker("Year", selection: $viewModel.selectedYear) {
                                ForEach(lowerBoundYear...(currentYear + 50), id: \.self) { year in
                                    Text(String(year)).tag(year)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                        }
                        .labelsHidden()
                        .onChange(of: viewModel.selectedMonth) { _, _ in
                            viewModel.applyMonthYearSelection()
                        }
                        .onChange(of: viewModel.selectedYear) { _, _ in
                            viewModel.applyMonthYearSelection()
                        }
                    }
                    .presentationCompactAdaptation(.popover)
                    .padding()
                }

                Spacer()

                Button(action: { viewModel.moveMonth(-1) }) {
                    Image(systemName: "chevron.left").foregroundColor(.orange).bold()
                }

                Spacer().frame(width: 28)

                Button(action: { viewModel.moveMonth(1) }) {
                    Image(systemName: "chevron.right").foregroundColor(.orange).bold()
                }
            }

            Spacer().frame(height: 15)

            // Week display
            HStack(spacing: 9) {
                ForEach(Array(viewModel.weekDates.enumerated()), id: \.offset) { _, date in
                    let status = viewModel.statusForDate(date)
                    VStack {
                        Text(viewModel.weekDays[Calendar.current.component(.weekday, from: date) - 1])
                            .foregroundColor(Color.gray)
                            .bold()
                            .font(.subheadline)

                        Text("\(Calendar.current.component(.day, from: date))")
                            .bold()
                            .font(.system(size: 25))
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(viewModel.backgroundColor(for: status))
                            )
                            .foregroundColor(viewModel.textColor(for: status))
                    }
                }
            }
        }
        .padding()
        .onChange(of: viewModel.currentDate) { _, newValue in
            viewModel.date = viewModel.firstDayOfMonth(for: newValue)
        }
    }
}





//Days Learned Struct
struct DaysLearned: View{
    var daysLearned: Int
    var body: some View{
        HStack{
            Spacer().frame(width: 12)
            Image(systemName: "flame.fill").foregroundStyle(Color.orange).font(Font.system(size: 20))
            
            
            VStack(alignment:.leading){
                Text("\(daysLearned)").bold().font(.system(size: 24))
                Text(daysLearned == 1 ? "Day Learned" : "Days Learned")
                    .font(.system(size: 12))
                    .animation(.easeInOut(duration: 0.2), value: daysLearned)
                Spacer().frame(height: 6)
            }.frame(width: 78,height: 49)
            Spacer().frame(width: 12)
        }.frame(width: 180 ,height:79)
        .glassEffect(.clear.tint(Color.orange.opacity(0.35)))
    }
}

//Days Freezed Struct
struct DaysFreezed: View {
    var freezesUsed: Int

    var body: some View {
        HStack {
            Spacer().frame(width: 14)
            Image(systemName: "cube.fill")
                .foregroundStyle(Color.blue)
                .font(.system(size: 20))
            
            VStack(alignment: .leading) {
                Text("\(freezesUsed)")
                    .bold()
                    .font(.system(size: 24))
                
                Text(freezesUsed == 1 ? "Day Freezed" : "Days Freezed")
                    .font(.system(size: 12))
                    .animation(.easeInOut(duration: 0.2), value: freezesUsed)
                
                Spacer().frame(height: 6)
            }
            .frame(width: 78, height: 49)
            
            Spacer().frame(width: 14)
        }
        .frame(width: 180, height: 79)
        .glassEffect(.regular.tint(Color.cyan.opacity(0.2)))
    }
}
