//
//  activityPage.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 26/04/1447 AH.
//

import SwiftUI

struct activityPage: View {
    @State private var isActive = false
    @StateObject private var viewModel = ActionLoggerViewModel()


    var body: some View {
        NavigationStack {
            
            VStack{
                Toolbar()
                
                CalendarProgressCard()
                Spacer().frame(height: 24)
                
                
                LearnedButton(viewModel: viewModel)
                Spacer().frame(height: 32)
                
                
                FreezedButton(viewModel: viewModel)
                Text("1 out of 2 Freezes used")
                    .font(Font.system(size: 14))
                    .foregroundStyle(Color.secondary)
            }
            
            .padding(16)
        }
    }
}


struct Toolbar: View {
    @State private var showCalendar = false
    @State private var showLearningGoal = false
    var body: some View {
        NavigationStack {
            
            HStack{
                Text("Activity")
                    .font(.system(size: 34, weight: .bold))
                Spacer()
                
                Button(action: {
                    showCalendar = true
                    print("Calendar button tapped")
                }) {
                    ZStack {
                        Circle()
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            .blur(radius: 1)
                            .glassEffect()
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: "calendar")
                            .foregroundColor(Color.white)
                            .font(.system(size: 17, weight: .bold))
                    }
                }     .navigationDestination(isPresented: $showCalendar) {
                    ScrollingCalendarView()
                        .navigationBarBackButtonHidden(true)
                }
                
                
                Button(action: {
                    showLearningGoal = true
                    print("Pencil button tapped")
                }) {
                    ZStack{
                        Circle()
                        .strokeBorder(
                            AngularGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.black.opacity(0.4), Color.white.opacity(0.6), Color.black.opacity(0.2), Color.white.opacity(0.9), Color.black.opacity(0.2), Color.black.opacity(0.4) ]),
                             center: .center ), lineWidth: 1 )
                        
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            .blur(radius: 1) .glassEffect() .frame(width: 44, height: 44)
                        Image(systemName: "pencil.and.outline")
                        .font(.system(size: 17, weight: .bold)) }
                    .foregroundStyle(Color.white)
                }.navigationDestination(isPresented: $showLearningGoal) {
                    LearningGoalView()
                        .navigationBarBackButtonHidden(true)
                    
                }
            }
        }
    }
}

struct CalendarProgressCard: View {
    @StateObject private var viewModel = CalendarProgressViewModel()

    var body: some View {
        ZStack {
            GlassEffectContainer {
                VStack(spacing: 16) {
                    MonthYearPickerView(
                        selectedDate: $viewModel.selectedDate,
                        showPicker: $viewModel.showPicker,
                        onWeekChange: viewModel.adjustWeek
                    )

                    HStack {
                        ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                            Text(day)
                                .font(.system(size: 13, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                        }
                    }

                    HStack {
                        ForEach(viewModel.weekDates, id: \.self) { date in
                            let dayNumber = Calendar.current.component(.day, from: date)
                            let isToday = Calendar.current.isDateInToday(date)
                            let isPast = date < Date() && !isToday

                            Circle()
                                .fill(isToday ? Color.orange :
                                        isPast ? Color.brown :
                                        Color.clear)
                                .frame(width: 44, height: 44)
                                .glassEffect()
                                .overlay(
                                    Text("\(dayNumber)")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor((isPast || isToday) ? .white : .primary)
                                )
                                .frame(maxWidth: .infinity)
                        }
                    }

                    Divider()

                    VStack(spacing: 12) {
                        Text("Learning Swift")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack(spacing: 12) {
                            // Learned Box
                            progressBox(
                                icon: "flame.fill",
                                color: .brownie,
                                count: viewModel.progress.daysLearned,
                                label: "Days Learned",
                                iconColor: .orange
                            )

                            // Frozen Box
                            progressBox(
                                icon: "cube.fill",
                                color: .coldBlue,
                                count: viewModel.progress.daysFrozen,
                                label: "Day Frozen",
                                iconColor: .blue
                            )
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .glassEffect(.clear, in: .rect(cornerRadius: 20))
            }

            if viewModel.showPicker {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showPicker = false
                    }

                VStack {
                    Spacer()

                    DatePicker("", selection: $viewModel.selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .frame(maxHeight: 200)
                        .clipped()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.bottom, 30)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: viewModel.showPicker)
            }

        }
    }

    // Helper View for Reuse
    func progressBox(icon: String, color: Color, count: Int, label: String, iconColor: Color) -> some View {
        ZStack {
            Rectangle()
                .fill(color)
                .cornerRadius(34)
                .opacity(0.8)
                .glassEffect()
                .frame(width: 160, height: 70)

            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.system(size: 15, weight: .bold))

                VStack(alignment: .leading) {
                    Text("\(count)")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))

                    Text(label)
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
    }
}

struct MonthYearPickerView: View {
    @Binding var selectedDate: Date
    @Binding var showPicker: Bool
    var onWeekChange: (Int) -> Void

    var body: some View {
        HStack {
            Button(action: {
                showPicker.toggle()
            }) {
                HStack(spacing: 4) {
                    Text(selectedDate.formatted(.dateTime.month(.wide).year()))
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)

                    Image(systemName: showPicker ? "chevron.down" : "chevron.right")
                        .foregroundStyle(Color.orange)
                        .bold()
                }
            }

            Spacer()

            Button(action: {
                onWeekChange(-1)
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.orange)
                    .bold()
            }
            .padding(.trailing, 20)

            Button(action: {
                onWeekChange(1)
            }) {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.orange)
                    .bold()
            }
        }
    }
}



//Log as Learned button
struct LearnedButton: View {
    @ObservedObject var viewModel: ActionLoggerViewModel

    var body: some View {
        Button(action: {
            viewModel.logAsLearned()
        }) {
            Text(viewModel.hasLogged ? "Learned Today" : "Log as Learned")
                .bold()
                .font(.system(size: 36))
                .foregroundStyle(viewModel.hasLogged ? Color.richOrange : Color.white)
                .padding(100)
        }
        .disabled(viewModel.hasLogged)
        .background(
            Circle()
                .fill(viewModel.hasLogged ? Color.brownishOrange.opacity(0.4) : Color.richOrange.opacity(0.95))
                .overlay(
                    Circle()
                        .strokeBorder(
                            AngularGradient(
                                gradient: Gradient(colors: viewModel.hasLogged ?
                                    [
                                      //  Color.richOrange.opacity(0.4),
                                        Color.orange.opacity(0.2),
                                        Color.black.opacity(0.2),
                                        Color.black.opacity(0.4),
                                        Color.black.opacity(0.2),
                                        Color.richOrange.opacity(0.2),
                                        Color.orange.opacity(0.4),
                                        Color.richOrange.opacity(0.3),
                                        Color.black.opacity(0.2),
                                        Color.black.opacity(0.4)
                                    ] :
                                    [
                                        Color.black.opacity(0.4),
                                        Color.white.opacity(0.6),
                                        Color.black.opacity(0.2),
                                        Color.white.opacity(0.9),
                                        Color.black.opacity(0.2),
                                        Color.black.opacity(0.4)
                                    ]
                                ),
                                center: .center
                            ),
                            lineWidth: 1
                        )
                )

                .glassEffect()
                .glassEffect(.clear.interactive())
        )

    }
}


//Log as freezed
struct FreezedButton: View {
    @ObservedObject var viewModel: ActionLoggerViewModel

    var body: some View {
        Button("Log as Freezed") {
            viewModel.logAsFreezed()
        }
        .disabled(viewModel.hasLogged)
        .foregroundStyle(Color.white)
        .font(.system(size: 17))
        .frame(width: 274, height: 48)
        .background(viewModel.loggedType == .freezed ? Color.gray.opacity(0.6) : Color.clear)
        .glassEffect(.regular.tint(Color.lightBlue.opacity(0.65)).interactive())
    }
}




#Preview {
    activityPage()
}
