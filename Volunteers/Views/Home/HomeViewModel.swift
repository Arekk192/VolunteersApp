//
//  HomeViewModel.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var events: [Event] = mockEvents
    @Published var isLoading = false
    @Published var error: String?
    
    private let calendarService: CalendarServiceProtocol = CalendarService()
    
    init() {}
        
    var polishMonthYear: String {
        calendarService.getPolishMonthYear(from: selectedDate)
    }
    
    var upcomingEvents: [Event] {
        events.sorted { $0.startDate < $1.startDate }
    }
    
    var weekdays: [String] {
        calendarService.weekdays
    }
        
    func getDaysInMonth() -> [Date?] {
        calendarService.getDaysInMonth(for: selectedDate)
    }
    
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendarService.isSameDay(date1, date2)
    }
    
    func hasEventOnDate(_ date: Date) -> Bool {
        calendarService.hasEventOnDate(date, events: events)
    }
    
    func isCurrentMonth(_ date: Date) -> Bool {
        calendarService.isCurrentMonth(date, relativeTo: selectedDate)
    }
    
    func moveMonth(by value: Int) {
        selectedDate = calendarService.moveMonth(selectedDate, by: value)
    }
        
    func refreshEvents() async {
        isLoading = true
        error = nil
        
        do {
            try await Task.sleep(nanoseconds: 500_000_000)
            events = mockEvents
        } catch {
            self.error = "Failed to load events: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func eventsForSelectedDate() -> [Event] {
        events.filter { calendarService.isSameDay($0.startDate, selectedDate) }
    }
}
