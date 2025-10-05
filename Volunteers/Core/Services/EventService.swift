//
//  EventService.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import Foundation
import Combine

final class MockEventService: ObservableObject {
    @Published var participationState: ParticipationState? = nil

    private var runningTasks: [Task<Void, Never>] = []

    func fetchEvent(id: UUID) async throws -> Event {
        try await Task.sleep(nanoseconds: 400_000_000)
        if let e = mockEvents.first(where: { $0.id == id }) {
            return e
        } else {
            throw NSError(domain: "MockEventService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Event not found"])
        }
    }

    func fetchMoreEvents(page: Int, limit: Int) async throws -> [Event] {
        try await Task.sleep(nanoseconds: 400_000_000)
        let start = max(0, (page - 1) * limit)
        guard start < mockEvents.count else { return [] }
        return Array(mockEvents.dropFirst(start).prefix(limit))
    }

    func requestParticipation(eventId: UUID) async throws {
        try await Task.sleep(nanoseconds: 300_000_000)
        await MainActor.run {
            self.participationState = .request
        }
    }

    func cancelParticipation(eventId: UUID) async throws {
        try await Task.sleep(nanoseconds: 300_000_000)
        await MainActor.run {
            self.participationState = ParticipationState.none
        }
    }

    func toggleParticipation(for eventId: UUID, current: ParticipationState) async throws -> ParticipationState {
        switch current {
        case .none:
            try await requestParticipation(eventId: eventId)
            return .request
        case .request:
            try await cancelParticipation(eventId: eventId)
            return .none
        case .accepted:
            try await cancelParticipation(eventId: eventId)
            return .none
        }
    }

    func fetchParticipation(for eventId: UUID) {
        let t = Task { @MainActor in
            try? await Task.sleep(nanoseconds: 250_000_000)

            self.participationState = ParticipationState.none
        }
        runningTasks.append(t)
    }

    func cancelAll() {
        runningTasks.forEach { $0.cancel() }
        runningTasks.removeAll()
    }
}
