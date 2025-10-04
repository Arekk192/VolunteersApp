//
//  HomeCalendarSection.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct HomeCalendarSection: View {
    @Binding var selectedDate: Date
    let events: [Event]
    
    private let months = [
        "Styczeń",
        "Luty",
        "Marzec",
        "Kwiecień",
        "Maj",
        "Czerwiec",
        "Lipiec",
        "Sierpień",
        "Wrzesień",
        "Październik",
        "Listopad",
        "Grudzień"
    ]
    private let weekdays = ["Pon", "Wt", "Śr", "Czw", "Pt", "Sob", "Ndz"]
    
    var body: some View {
        VStack(spacing: 12) {
            // Month and navigation
            HStack {
                Text(getPolishMonthYear(from: selectedDate))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button(action: { moveMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    
                    Button(action: { moveMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                }
            }
            
            // Weekday headers
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            
            // Calendar days
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(getDaysInMonth(), id: \.self) { date in
                    if let date = date {
                        HomeCalendarDayView(
                            date: date,
                            isSelected: isSameDay(date, selectedDate),
                            hasEvent: hasEventOnDate(date),
                            isCurrentMonth: isCurrentMonth(date)
                        )
                        .onTapGesture {
                            selectedDate = date
                        }
                    } else {
                        Rectangle()
                            .foregroundColor(.clear)
                    }
                }
            }
            .frame(height: 220, alignment: .top)
        }
        .padding()
        .background(.ultraThinMaterial)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
        .clipShape(.rect(cornerRadius: 15))
        
    }
    
    private func getPolishMonthYear(from date: Date) -> String {
        let monthIndex = calendar.component(.month, from: date) - 1
        let year = calendar.component(.year, from: date)
        return "\(months[monthIndex]) \(year)"
    }
    
    private func getDaysInMonth() -> [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: selectedDate) else { return [] }
        
        var days: [Date?] = []
        var currentDate = monthInterval.start
        
        let firstWeekday = calendar.component(.weekday, from: monthInterval.start)
                
        if firstWeekday == 1 {
            for _ in 0..<6 {
                days.append(nil)
            }
        } else {
            let emptyDaysCount = firstWeekday - 2
            if emptyDaysCount > 0 {
                for _ in 0..<emptyDaysCount {
                    days.append(nil)
                }
            }
        }
         
        while currentDate < monthInterval.end {
            days.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return days
    }
    
    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }
    
    private func hasEventOnDate(_ date: Date) -> Bool {
        events.contains { calendar.isDate($0.startDate, inSameDayAs: date) }
    }
    
    private func isCurrentMonth(_ date: Date) -> Bool {
        calendar.isDate(date, equalTo: selectedDate, toGranularity: .month)
    }
    
    private func moveMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: selectedDate) {
            selectedDate = newDate
        }
    }
    
    private let calendar = Calendar.current
}
