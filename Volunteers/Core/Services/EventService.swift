//
//  EventService.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI

protocol EventServiceProtocol {
    func fetchEvent(id: UUID) async throws -> Event
    func fetchMoreEvents(page: Int, limit: Int) async throws -> [Event]
    
    func requestParticipation(eventId: UUID) async throws
    func cancelParticipation(eventId: UUID) async throws
}

class MockEventService: EventServiceProtocol {
    func fetchEvent(id: UUID) async throws -> Event {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return mockEvents.first(where: { $0.id == id }) ?? mockEvents[0]
    }
    
    func fetchMoreEvents(page: Int, limit: Int) async throws -> [Event] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return Array(mockEvents.prefix(limit))
    }
    
    func requestParticipation(eventId: UUID) async throws {
        try await Task.sleep(nanoseconds: 500_000_000)
    }
    
    func cancelParticipation(eventId: UUID) async throws {
        try await Task.sleep(nanoseconds: 500_000_000)
    }
}
