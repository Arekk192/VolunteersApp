//
//  EventViewModel.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI
import MapKit
import Combine

@MainActor
final class EventViewModel: ObservableObject {
    
    @Published var event: Event
    @Published var position: MapCameraPosition
    @Published var participationState: ParticipationState = .none
    @Published var showQuestionsModal = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let eventService: EventServiceProtocol = MockEventService()
    
    init(event: Event) {
        self.event = event
        
        if let location = event.location {
            self.position = .region(MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        } else {
            self.position = .automatic
        }
    }
        
    func participateInEvent() {
        Task {
            await handleParticipation()
        }
    }
    
    func openInMaps() {
        guard let location = event.location else { return }
        location.toMapItem(name: event.title).openInMaps()
    }
    
    func loadEventDetails() {
        Task {
            await fetchEventDetails()
        }
    }
        
    func handleParticipation() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            switch participationState {
            case .none:
                try await eventService.requestParticipation(eventId: event.id)
                participationState = .request
                
            case .request:
                participationState = .none
                try await eventService.cancelParticipation(eventId: event.id)
                
            case .accepted:
                participationState = .none
                try await eventService.cancelParticipation(eventId: event.id)
            }
        } catch {
            errorMessage = "Failed to update participation: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func fetchEventDetails() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let updatedEvent = try await eventService.fetchEvent(id: event.id)
            self.event = updatedEvent
            
            if let location = updatedEvent.location {
                self.position = .region(
                    MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                )
            }
        } catch {
            errorMessage = "Failed to load event details: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    var eventDates: String {
        let startDate = event.startDate.formatted(as: "dd MMM HH:mm")
        let endDate = event.endDate.formatted(as: "dd MMM HH:mm")
        
        return "\(startDate) - \(endDate)"
    }
    
    struct ParticipationButtonData {
        let title: String
        let icon: String
        let color: Color
    }

    func getParticipationButtonData() -> ParticipationButtonData {
        switch event.participationState {
        case .accepted:
            return ParticipationButtonData(
                title: "Potwierdzono obecność",
                icon: "checkmark.circle.fill",
                color: Color.green
            )
        case .request:
            return ParticipationButtonData(
                title: "Oczekuje na potwierdzenie",
                icon: "clock.badge.questionmark",
                color: Color.orange
            )
        case .none:
            return ParticipationButtonData(
                title: "Weź udział",
                icon: "person.crop.circle.badge.plus",
                color: Color.blue
            )
        }
    }
}

