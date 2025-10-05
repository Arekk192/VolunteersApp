//
//  User.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct User: Identifiable, Hashable, Codable {
    var id = UUID()
    
    var displayName: String
    var profilePicture: String?
    var description: String
    
    var isAdult: Bool
    
    var organizations: [Organization]
 
    var lastMessage: String {
        return mockConversations.last?.text ?? "Rozpocznij konwersację"
    }
    
    var mockConversations: [Message] {
        return generateMockConversations()
    }
    
    private func generateMockConversations() -> [Message] {
        let calendar = Calendar.current
        let now = Date()
        
        switch displayName {
        case "Anna Kowalska":
            return [
                Message(text: "Cześć Anna! Czy możemy omówić nowy projekt społecznościowy w przyszłym tygodniu?", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -2, to: now)!),
                Message(text: "Oczywiście! Mam kilka pomysłów na rewitalizację podwórka.", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -1, to: now)!),
                Message(text: "Świetnie! Spotkajmy się w środę o 15:00 w centrum community.", isReply: false, sendAt: calendar.date(byAdding: .minute, value: -30, to: now)!)
            ]
        case "Jan Nowak":
            return [
                Message(text: "Hej Jan, potrzebujemy dodatkowych wolontariuszy na akcję ratowniczą w górach.", isReply: false, sendAt: calendar.date(byAdding: .day, value: -1, to: now)!),
                Message(text: "Mogę być dostępny w weekend. Ile osób jeszcze potrzebujecie?", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -12, to: now)!),
                Message(text: "Minimum 3 osoby. Szkolenie odbędzie się w piątek o 18:00.", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -1, to: now)!)
            ]
        case "Maria Wiśniewska":
            return [
                Message(text: "Cześć Maria! Mamy nową partię karmy w schronisku!", isReply: false, sendAt: calendar.date(byAdding: .day, value: -2, to: now)!),
                Message(text: "Doskonale! Akurat kończyły nam się zapasy. Przyjadę jutro rano.", isReply: true, sendAt: calendar.date(byAdding: .day, value: -1, to: now)!),
                Message(text: "Organizujemy też event adopcyjny w sobotę - pomożesz przy organizacji?", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -3, to: now)!)
            ]
        case "Piotr Lewandowski":
            return [
                Message(text: "Piotrze, sprzątanie parku odbędzie się w sobotę o 10:00", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -5, to: now)!),
                Message(text: "Super! Przyniosę worki i rękawice dla grupy.", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -4, to: now)!),
                Message(text: "Dziękuję! Zebraliśmy 50 worków śmieci na ostatniej akcji!", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -2, to: now)!)
            ]
        case "Katarzyna Zielińska":
            return [
                Message(text: "Katarzyno, mentoring młodzieży zaczyna się w przyszłym miesiącu", isReply: false, sendAt: calendar.date(byAdding: .day, value: -3, to: now)!),
                Message(text: "Już przygotowałam materiały. Czy mamy już listę uczestników?", isReply: true, sendAt: calendar.date(byAdding: .day, value: -2, to: now)!),
                Message(text: "Tak, 15 osób się zapisało. Pierwsze spotkanie 5-go.", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -6, to: now)!)
            ]
        case "Tomasz Wójcik":
            return [
                Message(text: "Tomasz, pan Jan czeka na wizytę w czwartek", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -8, to: now)!),
                Message(text: "Dobrze, odwiedzę go o 14:00. Czy potrzebuje czegoś z apteki?", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -7, to: now)!),
                Message(text: "Tak, prosił o leki na nadciśnienie. Dziękuję za pomoc!", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -4, to: now)!)
            ]
        case "Agnieszka Dąbrowska":
            return [
                Message(text: "Agnieszko, dostaliśmy dużą dostawę żywności do rozdysponowania", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -10, to: now)!),
                Message(text: "Ile rodzin możemy obsłużyć tym razem?", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -9, to: now)!),
                Message(text: "Około 100 rodzin. Akcja żywnościowa w sobotę - jesteś dostępna?", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -2, to: now)!)
            ]
        case "Michał Kamiński":
            return [
                Message(text: "Michał, nowy sprzęt ratowniczy już dotarł!", isReply: false, sendAt: calendar.date(byAdding: .day, value: -1, to: now)!),
                Message(text: "Świetnie! Kiedy możemy go przetestować?", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -20, to: now)!),
                Message(text: "Szkolenie z nowego sprzętu w niedzielę o 10:00.", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -5, to: now)!)
            ]
        case "Magdalena Kwiatkowska":
            return [
                Message(text: "Magdo, mamy nowe kotki do adopcji! Są przeurocze!", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -12, to: now)!),
                Message(text: "O nie! Musimy znaleźć im domy. Zrobię zdjęcia do ogłoszeń.", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -11, to: now)!),
                Message(text: "Event adopcyjny przeniesiony na przyszły weekend.", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -1, to: now)!)
            ]
        case "Krzysztof Mazur":
            return [
                Message(text: "Krzysztofie, materiały budowlane już dostarczone na plac budowy", isReply: false, sendAt: calendar.date(byAdding: .day, value: -2, to: now)!),
                Message(text: "Doskonale! Remont domu pani Zofii idzie zgodnie z planem.", isReply: true, sendAt: calendar.date(byAdding: .day, value: -1, to: now)!),
                Message(text: "Potrzebujemy dodatkowych rąk do pracy w sobotę. Możesz pomóc?", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -4, to: now)!)
            ]
        case "Zuzanna Szymańska":
            return [
                Message(text: "Zuzanno, warzywa w ogrodzie społecznościowym już dojrzewają!", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -24, to: now)!),
                Message(text: "Wspaniale! Zbierzemy je w czwartek z dziećmi z warsztatów.", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -20, to: now)!),
                Message(text: "Warsztaty ekologiczne dla dzieci w piątek o 16:00.", isReply: false, sendAt: calendar.date(byAdding: .hour, value: -2, to: now)!)
            ]
        default:
            return [
                Message(text: "Cześć! Jak tam Twoje projekty?", isReply: false, sendAt: calendar.date(byAdding: .day, value: -1, to: now)!),
                Message(text: "Wszystko idzie zgodnie z planem! Dziękuję za pytanie.", isReply: true, sendAt: calendar.date(byAdding: .hour, value: -12, to: now)!)
            ]
        }
    }
}


let mockUsers: [User] = [
    User(
        displayName: "Anna Kowalska",
        profilePicture: "https://picsum.photos/150/150?random=301",
        description: "Pasjonatka budowania społeczności i inicjatyw mieszkaniowych.",
        isAdult: true,
        organizations: [mockOrganizations[0], mockOrganizations[2]]
    ),
    User(
        displayName: "Jan Nowak",
        profilePicture: "https://picsum.photos/150/150?random=302",
        description: "Wolontariusz ratownictwa i koordynator pomocy w sytuacjach kryzysowych.",
        isAdult: false,
        organizations: [mockOrganizations[1], mockOrganizations[5]]
    ),
    User(
        displayName: "Maria Wiśniewska",
        profilePicture: "https://picsum.photos/150/150?random=303",
        description: "Działaczka na rzecz dobrostanu zwierząt, wolontariuszka w schronisku od 5+ lat.",
        isAdult: false,
        organizations: [mockOrganizations[3]]
    ),
    User(
        displayName: "Piotr Lewandowski",
        profilePicture: "https://picsum.photos/150/150?random=304",
        description: "Aktywista ekologiczny organizujący sprzątanie plaż i parków.",
        isAdult: true,
        organizations: [mockOrganizations[4], mockOrganizations[1]]
    ),
    User(
        displayName: "Katarzyna Zielińska",
        profilePicture: "https://picsum.photos/150/150?random=305",
        description: "Mentorka młodzieży i koordynatorka programów edukacyjnych.",
        isAdult: true,
        organizations: [mockOrganizations[5], mockOrganizations[2]]
    ),
    User(
        displayName: "Tomasz Wójcik",
        profilePicture: "https://picsum.photos/150/150?random=306",
        description: "Wolontariusz opieki nad seniorami i specjalista ds. współpracy ze społecznością.",
        isAdult: false,
        organizations: [mockOrganizations[6], mockOrganizations[0]]
    ),
    User(
        displayName: "Agnieszka Dąbrowska",
        profilePicture: "https://picsum.photos/150/150?random=307",
        description: "Koordynatorka dystrybucji żywności i działaczka na rzecz walki z głodem.",
        isAdult: true,
        organizations: [mockOrganizations[2], mockOrganizations[4]]
    ),
    User(
        displayName: "Michał Kamiński",
        profilePicture: "https://picsum.photos/150/150?random=308",
        description: "Członek zespołu ratownictwa i instruktor pierwszej pomocy.",
        isAdult: false,
        organizations: [mockOrganizations[1], mockOrganizations[3]]
    ),
    User(
        displayName: "Magdalena Kwiatkowska",
        profilePicture: "https://picsum.photos/150/150?random=309",
        description: "Wolontariuszka ratownictwa zwierząt i organizatorka eventów adopcyjnych.",
        isAdult: false,
        organizations: [mockOrganizations[3], mockOrganizations[6]]
    ),
    User(
        displayName: "Krzysztof Mazur",
        profilePicture: "https://picsum.photos/150/150?random=310",
        description: "Wolontariusz budowlany i lider projektów remontowych domów.",
        isAdult: true,
        organizations: [mockOrganizations[0], mockOrganizations[4], mockOrganizations[1]]
    ),
    User(
        displayName: "Zuzanna Szymańska",
        profilePicture: "https://picsum.photos/150/150?random=311",
        description: "Koordynatorka ogrodów społecznościowych i edukatorka ekologiczna.",
        isAdult: false,
        organizations: [mockOrganizations[4], mockOrganizations[5], mockOrganizations[2]]
    )
]
