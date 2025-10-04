//
//  HomeUpcomingEvents.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct HomeUpcomingEvents: View {
    let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nadchodzące wydarzenia")
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVStack(spacing: 12) {
                ForEach(events.sorted(by: { $0.startDate < $1.startDate })) { event in
                    EventRow(event)
                }
            }
        }
    }
}

fileprivate struct EventRow: View {
    let event: Event
    @State private var geocodedLocation: String = ""
    
    init(_ event: Event) {
        self.event = event
    }
    
    var body: some View {
        NavigationLink(value: event) {
            HStack(spacing: 16) {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 4)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                    
                    HStack {
                        Image(systemName: "clock")
                            .font(.caption)
                        
                        Text("\(event.startDate.formatted(as: "dd MMM yyyy hh:mm")) - \(event.endDate.formatted(as: "dd MMM yyyy hh:mm"))")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "location")
                            .font(.caption)
                        
                        Text(geocodedLocation)
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
        }
        .task {
            do {
                geocodedLocation = try await event.location.toAddress()
            } catch {
                geocodedLocation = ""
            }
        }
    }
}
