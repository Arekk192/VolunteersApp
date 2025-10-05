//
//  CalendarService.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI

protocol CalendarServiceProtocol {
    func getDaysInMonth(for date: Date) -> [Date?]
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool
    func hasEventOnDate(_ date: Date, events: [Event]) -> Bool
    func isCurrentMonth(_ date: Date, relativeTo referenceDate: Date) -> Bool
    func moveMonth(_ date: Date, by value: Int) -> Date
    func getPolishMonthYear(from date: Date) -> String
    
    var weekdays: [String] { get }
    var months: [String] { get }
}

class CalendarService: CalendarServiceProtocol {
    private let calendar = Calendar.current
    
    func getDaysInMonth(for date: Date) -> [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else { return [] }
        
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
    
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func hasEventOnDate(_ date: Date, events: [Event]) -> Bool {
        events.contains { isSameDay($0.startDate, date) }
    }
    
    func isCurrentMonth(_ date: Date, relativeTo referenceDate: Date) -> Bool {
        calendar.isDate(date, equalTo: referenceDate, toGranularity: .month)
    }
    
    func moveMonth(_ date: Date, by value: Int) -> Date {
        calendar.date(byAdding: .month, value: value, to: date) ?? date
    }
    
    func getPolishMonthYear(from date: Date) -> String {
        let monthIndex = calendar.component(.month, from: date) - 1
        let year = calendar.component(.year, from: date)
        return "\(months[monthIndex]) \(year)"
    }
    
    var weekdays: [String] { ["Pon", "Wt", "Śr", "Czw", "Pt", "Sob", "Ndz"] }
    var months: [String] {
        [
            "Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec",
            "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"
        ]
    }
}
