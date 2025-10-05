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
