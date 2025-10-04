//
//  HomeView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var events: [Event] = mockEvents
    
    private let calendar = Calendar.current
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    HomeCalendarSection(
                        selectedDate: $selectedDate,
                        events: events
                    )
                    
                    HomeUpcomingEvents(events: events)
                }
                .padding()
            }
            .navigationTitle("Projekty")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationDestination(for: Event.self) { event in
                EventView(event: event)
            }
        }
    }
}

#Preview {
    HomeView()
}
