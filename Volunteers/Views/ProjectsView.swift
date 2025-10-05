//
//  ProjectsView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct ProjectsView: View {
    let events: [Event] = mockEvents
    
    @State private var searchText: String = ""
    @FocusState private var searchFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(events) { event in
                        NavigationLink(value: event) {
                            EventCardView(event: event)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Wydarzenia")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Event.self) { event in
                EventView(event: event)
            }
            .safeAreaBar(edge: .top) {
                SearchBar(text: $searchText, focused: $searchFocused)
                    .padding(.horizontal)
            }
        }
    }
}

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let imageUrl = event.imageURLs.first {
                CacheImage(imageUrl, contentMode: .fill, aspectRatio: 3 / 4) {
                    Image(systemName: "photo")
                }
                .frame(height: 240)
                .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 240)
            }
            
            LinearGradient(
                colors: [.black.opacity(1), .black.opacity(0)],
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 100)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(1)
                
                Text(event.startDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
        }
        .clipShape(.rect(cornerRadius: 15))
        .shadow(radius: 4, y: 2)
    }
}

#Preview {
    ProjectsView()
}
