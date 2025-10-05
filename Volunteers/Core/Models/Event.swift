//
//  Event.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI
import MapKit
import GeoToolbox

struct EventFeedback: Codable, Hashable {
    let comment: String
    let addedDate: Date
}

struct Event: Identifiable, Hashable {
    let id = UUID()
    let organizationId: UUID
    let title: String
    let description: String
    let location: EventLocation?
    let startDate: Date
    let endDate: Date
    let imageURLs: [String]
    let feedback: EventFeedback?
    
    var date: Date { startDate }
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
        
//         request.isCancelled
        
        return mapItem.address?.shortAddress ?? "Nieznany adres"
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
        title: "Sprzątanie parku miejskiego",
        description: "Wspólne sprzątanie zielonych terenów w centrum miasta",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 7), // 7 dni temu
        endDate: Date().addingTimeInterval(-86400 * 7 + 10800),
        imageURLs: ["https://picsum.photos/seed/parkcleanup/900/600"],
        feedback: EventFeedback(
            comment: "Arkadiusz wykazał się niezwykłą sumiennością podczas sprzątania. Jego zaangażowanie w segregację odpadów było wzorowe.",
            addedDate: Date().addingTimeInterval(-86400 * 6)
        )
    ),
    Event(
        organizationId: UUID(),
        title: "Pomoc w schronisku dla zwierząt",
        description: "Opieka nad bezdomnymi psami i kotami, spacery i sprzątanie boksów",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 14), // 14 dni temu
        endDate: Date().addingTimeInterval(-86400 * 14 + 14400),
        imageURLs: ["https://picsum.photos/seed/animalShelter/900/600"],
        feedback: EventFeedback(
            comment: "Bardzo opiekuńczy wobec zwierząt, szczególnie delikatny z przestraszonymi psami. Ma naturalny talent do pracy ze zwierzętami.",
            addedDate: Date().addingTimeInterval(-86400 * 13)
        )
    ),
    Event(
        organizationId: UUID(),
        title: "Zbiórka żywności dla potrzebujących",
        description: "Wolontariat w banku żywności - sortowanie i pakowanie darów",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 21), // 21 dni temu
        endDate: Date().addingTimeInterval(-86400 * 21 + 7200),
        imageURLs: ["https://picsum.photos/seed/fooddrive/900/600"],
        feedback: EventFeedback(
            comment: "Niezwykle efektywny i zorganizowany. Pomógł usprawnić proces pakowania, co znacząco przyspieszyło naszą pracę.",
            addedDate: Date().addingTimeInterval(-86400 * 20)
        )
    ),
    Event(
        organizationId: UUID(),
        title: "Warsztaty edukacyjne dla dzieci",
        description: "Prowadzenie kreatywnych zajęć dla dzieci z domów dziecka",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 30), // 30 dni temu
        endDate: Date().addingTimeInterval(-86400 * 30 + 10800),
        imageURLs: [
            "https://picsum.photos/seed/workshop1/900/600",
            "https://picsum.photos/seed/workshop2/900/600"
        ],
        feedback: EventFeedback(
            comment: "Świetny kontakt z dziećmi, bardzo kreatywny w wymyślaniu zabaw. Czasem mógłby bardziej angażować nieśmiałe dzieci.",
            addedDate: Date().addingTimeInterval(-86400 * 29)
        )
    ),
    Event(
        organizationId: UUID(),
        title: "Odkrzaczanie szlaków turystycznych",
        description: "Prace porządkowe na górskich szlakach w ramach akcji 'Czyste Góry'",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 45), // 45 dni temu
        endDate: Date().addingTimeInterval(-86400 * 45 + 21600),
        imageURLs: ["https://picsum.photos/seed/hiking/900/600"],
        feedback: EventFeedback(
            comment: "Wysoka wytrzymałość fizyczna i doskonała praca w zespole. Pomógł w najtrudniejszych odcinkach szlaku.",
            addedDate: Date().addingTimeInterval(-86400 * 44)
        )
    ),
    Event(
        organizationId: UUID(),
        title: "Towarzystwo dla seniorów",
        description: "Wizyty i wsparcie dla osób starszych w domopomocy",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 60), // 60 dni temu
        endDate: Date().addingTimeInterval(-86400 * 60 + 7200),
        imageURLs: ["https://picsum.photos/seed/seniors/900/600"],
        feedback: EventFeedback(
            comment: "Niezwykła cierpliwość i empatia w kontaktach z seniorami. Wielu podopiecznych pytało o następne wizyty.",
            addedDate: Date().addingTimeInterval(-86400 * 59)
        )
    ),
    Event(
        organizationId: UUID(),
        title: "Organizacja biegów charytatywnych",
        description: "Logistyka i pomoc przy organizacji biegu na rzecz hospicjum",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 75), // 75 dni temu
        endDate: Date().addingTimeInterval(-86400 * 75 + 28800),
        imageURLs: [
            "https://picsum.photos/seed/charityrun1/900/600",
            "https://picsum.photos/seed/charityrun2/900/600"
        ],
        feedback: EventFeedback(
            comment: "Doskonały w rozwiązywaniu problemów logistycznych. Pomógł w kryzysowej sytuacji z brakiem wody na trasie.",
            addedDate: Date().addingTimeInterval(-86400 * 74)
        )
    ),
    Event(
        organizationId: UUID(),
        title: "Remont świetlicy środowiskowej",
        description: "Prace remontowe i malowanie pomieszczeń dla dzieci",
        location: EventLocation(latitude: 52.2297, longitude: 21.0122),
        startDate: Date().addingTimeInterval(-86400 * 90), // 90 dni temu
        endDate: Date().addingTimeInterval(-86400 * 90 + 18000),
        imageURLs: ["https://picsum.photos/seed/renovation/900/600"],
        feedback: EventFeedback(
            comment: "Dobrze radził sobie z pracami malarskimi, ale potrzebował więcej nadzoru przy pracach wymagających precyzji.",
            addedDate: Date().addingTimeInterval(-86400 * 89)
        )
    )
]
