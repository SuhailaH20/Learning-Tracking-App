//
//  ActivityCard.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 01/05/1447 AH.
//
import SwiftUI

//Card Struct
struct CurrentCard: View {
    var body: some View {
        GlassEffectContainer {
            HStack {
                VStack (alignment:.leading) {
                    CalendarHorizontalView()
                    Spacer().frame(height: 12)
                    Divider()
                    Spacer().frame(height: 11.5)
                    Text("Learning Swift")
                        .bold()
                        .padding(.horizontal)
                    Spacer().frame(height: 12)

                    HStack{
                        Spacer()
                        //Days learned
                        DaysLearned()
                        
                        Spacer().frame(width:13)

                        //Days freezed
                        
                        DaysFreezed()
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
            Image(systemName: "calendar")
                .font(Font.system(size: 20))
                .frame(width:44 ,height: 44)
                .glassEffect()
                
            
            Image(systemName: "pencil.and.outline")
                .font(Font.system(size: 20))
                .frame(width:44 ,height: 44)
                .glassEffect()

        }
    }
}

//Calendar Struct
struct CalendarHorizontalView: View {
    @State private var currentDate = Date()
    // Keep a Date for the weekly view base
    @State private var date = Date()
    @State private var showingDatePicker = false

    // Custom month/year wheel state
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date()) - 1 // 0...11
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
 
    private var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    private var weekDays: [String] {
        let formatter = DateFormatter()
        return formatter.shortWeekdaySymbols // ["Sun","Mon",...]
    }
    
    private var weekDates: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(monthYear).bold()
                Button(action: {
                    // Initialize wheels from currentDate whenever opening
                    let comps = Calendar.current.dateComponents([.year, .month], from: currentDate)
                    selectedMonth = (comps.month ?? 1) - 1
                    selectedYear = comps.year ?? selectedYear
                    showingDatePicker = true
                }) {
                    Image(systemName: showingDatePicker ? "chevron.down" : "chevron.right")
                        .foregroundColor(.orange)
                        .bold()
                }
                .popover(isPresented: $showingDatePicker, arrowEdge: .top) {
                    VStack(spacing: 16) {
                        HStack(spacing:0) {
                            // Month wheel
                            Picker("Month", selection: $selectedMonth) {
                                ForEach(0..<12, id: \.self) { index in
                                    Text(DateFormatter().monthSymbols[index]).tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)

                            // Year wheel (before 2025 and forward, default to current year)
                            let currentYear = Calendar.current.component(.year, from: Date())
                            let lowerBoundYear = 1900 // adjust as needed
                            Picker("Year", selection: $selectedYear) {
                                ForEach(lowerBoundYear...(currentYear + 50), id: \.self) { year in
                                    // Force plain string to avoid locale grouping separators like "2,025"
                                    Text(String(year)).tag(year)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                        }
                        .labelsHidden()
                        .onChange(of: selectedMonth) { _, _ in
                            applyMonthYearSelection()
                        }
                        .onChange(of: selectedYear) { _, _ in
                            applyMonthYearSelection()
                        }
                    }
                    .presentationCompactAdaptation(.popover)
                    .padding()
                }
                Spacer()
                
                Button(action: { moveMonth(-1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.orange)
                        .bold()
                }
                Spacer().frame(width: 28)
                
                Button(action: { moveMonth(1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.orange)
                        .bold()
                }
            }
            
            Spacer().frame(height: 15)
            
            HStack(spacing: 9) {
                ForEach(Array(weekDates.enumerated()), id: \.offset) { _, date in
                    let weekdayIndex = Calendar.current.component(.weekday, from: date) - 1
                    VStack {
                        Text(weekDays[Calendar.current.component(.weekday, from: date) - 1])
                            .foregroundColor(Color.gray)
                            .bold()
                            .font(.subheadline)
                        
                        Text("\(Calendar.current.component(.day, from: date))")
                            .foregroundColor(Color.cyan)
                            .bold()
                            .font(.system(size: 25))
                            .frame(width: 44,height:44)
                            .background(
                                Circle().fill(Color.coldBlue)
                            )
                    }
                }
            }
        }
        .padding()
        // Keep the legacy date binding in sync if used elsewhere
        .onChange(of: currentDate) { _, newValue in
            date = firstDayOfMonth(for: newValue)
        }
    }
    
    private func moveMonth(_ value: Int) {
        if let newDate = Calendar.current.date(byAdding: .weekOfYear, value: value, to: currentDate) {
                 currentDate = newDate
        }
    }
    
    private func firstDayOfMonth(for date: Date) -> Date {
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: comps) ?? date
    }

    private func applyMonthYearSelection() {
        var comps = DateComponents()
        comps.year = selectedYear
        comps.month = selectedMonth + 1 // DateComponents months are 1-based
        comps.day = 1
        if let composed = Calendar.current.date(from: comps) {
            currentDate = composed
        }
    }
}




//Days Learned Struct
struct DaysLearned: View{
    var body: some View{
        HStack{
            Spacer().frame(width: 12)
            Image(systemName: "flame.fill").foregroundStyle(Color.orange).font(Font.system(size: 20))
            
            
            VStack(alignment:.leading){
                Text("3").bold().font(.system(size: 24))
                Text("Days Learned").font(.system(size: 12))
                Spacer().frame(height: 6)
            }.frame(width: 78,height: 49)
            Spacer().frame(width: 12)
        }.frame(width: 180 ,height:79)
        .glassEffect(.clear.tint(Color.orange.opacity(0.35)))
    }
}

//Days Freezed Struct
struct DaysFreezed: View{
    @State private var freezesUsed: Int = 0

    var body: some View{
        HStack{
            Spacer().frame(width: 14)
            Image(systemName: "cube.fill").foregroundStyle(Color.blue).font(Font.system(size: 20))
            
            VStack(alignment:.leading){
                Text("\(freezesUsed)").bold().font(.system(size: 24))
                Text("Days Freezed").font(.system(size: 12))
                Spacer().frame(height: 6)

            }.frame(width: 78,height: 49)
            Spacer().frame(width: 14)
        }
        .frame(width: 180 ,height:79)
        .glassEffect(.regular.tint(Color.cyan.opacity(0.2)))
    }
}
