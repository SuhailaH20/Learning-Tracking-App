import SwiftUI

struct ScrollingCalendarView: View {
    @ObservedObject var activityViewModel: ActivityPageViewModel
    @StateObject private var calendarViewModel: CalendarViewModel

    // MARK: - Init
    init(activityViewModel: ActivityPageViewModel) {
        self._activityViewModel = ObservedObject(wrappedValue: activityViewModel)
        _calendarViewModel = StateObject(wrappedValue: CalendarViewModel(activityViewModel: activityViewModel))
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Scrollable content
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(calendarViewModel.months, id: \.self) { monthStart in
                        CalendarMonthView(viewModel: calendarViewModel, monthStart: monthStart)
                            .frame(width: 338)
                        
                        Spacer().frame(height: 8)

                        Rectangle()
                            .frame(height: 0.5)
                            .padding(.horizontal, 28)
                            .foregroundStyle(Color.newGrey)

                        Spacer().frame(height: 24)
                    }
                }
                .padding(.top, 150) // Match nav bar height
            }

            // Transparent navigation bar
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 44, height: 44)
                        .opacity(0)
                }

                Spacer()

                Text("All activities")
                    .font(.system(size: 17, weight: .semibold))

                Spacer()

                Circle()
                    .frame(width: 44, height: 44)
                    .opacity(0)
            }
            .padding(.horizontal)
            .frame(height: 190)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .edgesIgnoringSafeArea(.top)
    }
}




struct CalendarMonthView: View {
    let viewModel: CalendarViewModel
    let monthStart: Date

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.formattedMonth(from: monthStart))
                .font(.system(size: 17, weight: .semibold))
            Spacer().frame(height: 8)
            CalendarWeekHeaderView(weekDays: viewModel.weekDaySymbols())

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(viewModel.daysInMonth(from: monthStart), id: \.self) { date in
                    CalendarDayView(viewModel: viewModel, date: date)
                }
            }
        }
    }
}


struct CalendarWeekHeaderView: View {
    let weekDays: [String]

    var body: some View {
        HStack {
            ForEach(weekDays, id: \.self) { day in
                Text(day)
                    .font(.system(size: 13, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct CalendarDayView: View {
    let viewModel: CalendarViewModel
    let date: Date

    var body: some View {
        if viewModel.isPlaceholder(date) {
            Text("")
                .frame(maxWidth: .infinity)
        } else {
            ZStack {
                // Background style
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(backgroundColor(for: date))
                    .glassEffect()

                // Day number style
                Text("\(viewModel.dayNumber(from: date))")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(textColor(for: date))
                    .padding(1)
            }
        }
    }

    // MARK: - Styling Helpers

    func backgroundColor(for date: Date) -> Color {
        if viewModel.isLogged(date) {
            return Color.richOrange.opacity(0.2)
        } else if viewModel.isFreezed(date) {
            return Color.cyan.opacity(0.3)
        } else if viewModel.isToday(date) {
            return Color.richOrange
        } else {
            return Color.clear
        }
    }

    func textColor(for date: Date) -> Color {
        if viewModel.isLogged(date) {
            return Color.orange
        } else if viewModel.isFreezed(date) {
            return Color.cyan
        } else if viewModel.isToday(date) {
            return Color.white
        } else {
            return Color.primary
        }
    }
}


//#Preview {
//    ScrollingCalendarView()
//}
