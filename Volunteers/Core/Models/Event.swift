//
//  Event.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI
import MapKit
import GeoToolbox

struct Event: Identifiable, Codable, Hashable {
    var id = UUID()
    var organizationId: UUID
    
    var title: String
    var description: String
    var location: EventLocation
    var startDate: Date
    var endDate: Date
    var imageURLs: [String]
}

struct EventLocation: Codable, Hashable {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
    
    init(mapItem: MKMapItem) {
        let coordinate = mapItem.location.coordinate
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static func fromAddress(_ address: String) async throws -> EventLocation {
        let descriptor = PlaceDescriptor(
            representations: [.address(address)],
            commonName: address
        )
        
        let request = MKMapItemRequest(placeDescriptor: descriptor)
        let location = try await request.mapItem.location
        
        return EventLocation(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
    
    func toAddress() async throws -> String {
        let descriptor = PlaceDescriptor(
            representations: [.coordinate(coordinate)],
            commonName: "Location"
        )
        
        let request = MKMapItemRequest(placeDescriptor: descriptor)
        let mapItem = try await request.mapItem
        
        // request.isLoading
        
        return mapItem.address?.fullAddress ?? "Nieznany adres"
    }
    
    func toMapItem(name: String? = nil) -> MKMapItem {
        let mapItem = MKMapItem(location: CLLocation(latitude: self.latitude, longitude: self.longitude), address: nil)
        mapItem.name = name
        return mapItem
    }
}

var mockEvents = [
    Event(
        organizationId: UUID(),
        title: "Spotkanie zespołu",
        description: "Cotygodniowe spotkanie zespołu developerskiego",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(3600),
        endDate: Date().addingTimeInterval(7200),
        imageURLs: ["https://picsum.photos/seed/team1/900/1200"]
    ),
    Event(
        organizationId: UUID(),
        title: "Lunch z klientem",
        description: "Spotkanie biznesowe z kluczowym klientem",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(10800),
        endDate: Date().addingTimeInterval(16200),
        imageURLs: ["https://picsum.photos/seed/lunch1/900/1200"]
    ),
    Event(
        organizationId: UUID(),
        title: "Deadline projektu",
        description: "Ostateczny termin oddania projektu",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(86400),
        endDate: Date().addingTimeInterval(90000),
        imageURLs: ["https://picsum.photos/seed/deadline1/900/1200"]
    ),
    Event(
        organizationId: UUID(),
        title: "Przegląd designu",
        description: "Prezentacja i przegląd nowych projektów UI/UX",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(172800),
        endDate: Date().addingTimeInterval(180000),
        imageURLs: ["https://picsum.photos/seed/design1/900/1200"]
    ),
    Event(
        organizationId: UUID(),
        title: "Warsztaty programistyczne",
        description: "Szkolenie z nowych technologii programistycznych",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(259200),
        endDate: Date().addingTimeInterval(270000),
        imageURLs: [
            "https://picsum.photos/seed/workshop1/900/1200",
            "https://picsum.photos/seed/workshop2/900/1200"
        ]
    )
]
