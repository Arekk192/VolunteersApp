//
//  HomeView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    HomeCalendarSection(viewModel: viewModel)
                    
                    UpcomingEvents()
                }
                .padding()
            }
            .navigationTitle("Projekty")
            .navigationDestination(for: Event.self) { event in
                EventView(event: event)
            }
            .task { await viewModel.refreshEvents() }
            .refreshable { await viewModel.refreshEvents() }
        }
    }
    
    @ViewBuilder
    private func UpcomingEvents() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nadchodzące wydarzenia")
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVStack(spacing: 12) {
                ForEach(viewModel.events.sorted(by: { $0.startDate < $1.startDate })) { event in
                    HomeEventRow(event)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
