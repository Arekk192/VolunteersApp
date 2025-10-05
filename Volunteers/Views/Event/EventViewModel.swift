//
//  EventViewModel.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI
import MapKit
import Combine


//@MainActor
//final class EventViewModel: ObservableObject {
//    
//    @Published var event: Event
//    @Published var position: MapCameraPosition
//    @Published var participationState: ParticipationState = .none
//    
//    @Published var showParticipationModal = false
//    @Published var showQuestionsModal = false
//    
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    
//    private let eventService: EventServiceProtocol = MockEventService()
//    
//    init(event: Event) {
//        self.event = event
//        
//        if let location = event.location {
//            self.position = .region(MKCoordinateRegion(
//                center: location.coordinate,
//                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            ))
//        } else {
//            self.position = .automatic
//        }
//    }
//    
//    private var participationTask: Task<Void, Never>?
//    
//    deinit {
//        participationTask?.cancel()
//    }
//    
//    func handleParticipation() async {
//        participationTask?.cancel()
//        
//        participationTask = Task { @MainActor in
//            isLoading = true
//            errorMessage = nil
//            
//            do {
//                try Task.checkCancellation()
//                
//                try await Task.sleep(nanoseconds: 1_000_000_000)
//                
//                try Task.checkCancellation()
//                
//                switch participationState {
//                case .none:
//                    event.participationState = .request
//                    
//                case .request, .accepted:
//                    event.participationState = .none
//                }
//            } catch {
//                errorMessage = "Failed to update participation: \(error.localizedDescription)"
//            }
//            
//            isLoading = false
//        }
//        
//        await participationTask?.value
//    }
//    
//    func cancelOperations() {
//        participationTask?.cancel()
//    }
//        
//    func participateInEvent() {
//        Task {
//            await handleParticipation()
//        }
//    }
//    
//    func openInMaps() {
//        guard let location = event.location else { return }
//        location.toMapItem(name: event.title).openInMaps()
//    }
//    
//    func loadEventDetails() {
//        Task {
//            await fetchEventDetails()
//        }
//    }
//    
//    private func fetchEventDetails() async {
//        isLoading = true
//        errorMessage = nil
//        
//        do {
//            let updatedEvent = try await eventService.fetchEvent(id: event.id)
//            self.event = updatedEvent
//            
//            if let location = updatedEvent.location {
//                self.position = .region(
//                    MKCoordinateRegion(
//                        center: location.coordinate,
//                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                    )
//                )
//            }
//        } catch {
//            errorMessage = "Failed to load event details: \(error.localizedDescription)"
//        }
//        
//        isLoading = false
//    }
//    
//    
//}

import SwiftUI
import Combine
import MapKit

@MainActor
final class EventViewModel: ObservableObject {
    @Published var event: Event
    @Published var participationState: ParticipationState = .none
    @Published var isLoading: Bool = false
    @Published var showQuestionsModal: Bool = false
    @Published var showParticipationModal: Bool = false
    @Published var position: MapCameraPosition = .automatic

    private let dataService: MockEventService = MockEventService()
    private var cancellables = Set<AnyCancellable>()
    private var lastParticipationUpdate: Date? = nil

    init(event: Event) {
        self.event = event

        if let location = event.location {
            position = .region(
                MKCoordinateRegion(
                    center: location.coordinate,
                    span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }

        addSubscribers()
        fetchParticipationState(for: event.id)
    }

    private func addSubscribers() {
        dataService.$participationState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self, let state = state else { return }
                self.participationState = state
                self.lastParticipationUpdate = Date()
            }
            .store(in: &cancellables)
    }

    func handleParticipation() async {
        guard !isLoading else { return }
        isLoading = true
        
        defer { isLoading = false }

        do {
            let newState = try await dataService.toggleParticipation(for: event.id, current: participationState)

            participationState = newState
            lastParticipationUpdate = Date()
        } catch {
            print("⚠️ Error updating participation: \(error)")
        }
    }

    func fetchParticipationState(for eventId: UUID) {
        dataService.fetchParticipation(for: eventId)
    }

    func cancelOperations() {
        cancellables.removeAll()
        dataService.cancelAll()
    }

    var eventDates: String {
        let startDate = event.startDate.formatted(as: "dd MMM HH:mm")
        let endDate = event.endDate.formatted(as: "dd MMM HH:mm")
        
        return "\(startDate) - \(endDate)"
     }
}

