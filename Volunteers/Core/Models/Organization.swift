//
//  Organization.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct Organization: Identifiable, Hashable, Codable {
    var id = UUID()
    
    var name: String
    var description: String
    var profileImage: String?
    var backgroundImage: String?
}

let mockOrganizations: [Organization] = [
    Organization(
        name: "Habitat for Humanity",
        description: "Building homes and hope for families in need through volunteer labor and donations.",
        profileImage: "https://picsum.photos/200/200?random=101",
        backgroundImage: "https://picsum.photos/400/200?random=201"
    ),
    Organization(
        name: "Red Cross",
        description: "Providing emergency assistance, disaster relief, and education in communities worldwide.",
        profileImage: "https://picsum.photos/200/200?random=102",
        backgroundImage: "https://picsum.photos/400/200?random=202"
    ),
    Organization(
        name: "Food Bank Network",
        description: "Fighting hunger by distributing meals and groceries to food-insecure families.",
        profileImage: "https://picsum.photos/200/200?random=103",
        backgroundImage: "https://picsum.photos/400/200?random=203"
    ),
    Organization(
        name: "Animal Rescue League",
        description: "Saving and protecting animals through rescue, adoption, and community education.",
        profileImage: "https://picsum.photos/200/200?random=104",
        backgroundImage: "https://picsum.photos/400/200?random=204"
    ),
    Organization(
        name: "Clean Earth Initiative",
        description: "Organizing community cleanups and promoting environmental conservation efforts.",
        profileImage: "https://picsum.photos/200/200?random=105",
        backgroundImage: "https://picsum.photos/400/200?random=205"
    ),
    Organization(
        name: "Youth Mentorship Program",
        description: "Connecting young people with mentors to support their personal and academic growth.",
        profileImage: "https://picsum.photos/200/200?random=106",
        backgroundImage: "https://picsum.photos/400/200?random=206"
    ),
    Organization(
        name: "Senior Care Alliance",
        description: "Providing companionship and assistance to elderly community members.",
        profileImage: "https://picsum.photos/200/200?random=107",
        backgroundImage: "https://picsum.photos/400/200?random=207"
    )
]
