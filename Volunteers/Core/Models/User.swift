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
    
    var organizations: [Organization]
}

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

let mockUsers: [User] = [
    User(
        displayName: "Sarah Johnson",
        profilePicture: "https://picsum.photos/150/150?random=301",
        description: "Passionate about community building and affordable housing initiatives.",
        organizations: [mockOrganizations[0], mockOrganizations[2]]
    ),
    User(
        displayName: "Marcus Chen",
        profilePicture: "https://picsum.photos/150/150?random=302",
        description: "Emergency response volunteer and disaster relief coordinator.",
        organizations: [mockOrganizations[1], mockOrganizations[5]]
    ),
    User(
        displayName: "Elena Rodriguez",
        profilePicture: "https://picsum.photos/150/150?random=303",
        description: "Animal welfare advocate and shelter volunteer for 5+ years.",
        organizations: [mockOrganizations[3]]
    ),
    User(
        displayName: "David Thompson",
        profilePicture: "https://picsum.photos/150/150?random=304",
        description: "Environmental activist organizing beach and park cleanups.",
        organizations: [mockOrganizations[4], mockOrganizations[1]]
    ),
    User(
        displayName: "Priya Patel",
        profilePicture: "https://picsum.photos/150/150?random=305",
        description: "Youth mentor and education program coordinator.",
        organizations: [mockOrganizations[5], mockOrganizations[2]]
    ),
    User(
        displayName: "James Wilson",
        profilePicture: "https://picsum.photos/150/150?random=306",
        description: "Senior care volunteer and community outreach specialist.",
        organizations: [mockOrganizations[6], mockOrganizations[0]]
    ),
    User(
        displayName: "Maya Williams",
        profilePicture: "https://picsum.photos/150/150?random=307",
        description: "Food distribution coordinator and hunger relief advocate.",
        organizations: [mockOrganizations[2], mockOrganizations[4]]
    ),
    User(
        displayName: "Alex Kim",
        profilePicture: "https://picsum.photos/150/150?random=308",
        description: "Disaster response team member and first aid instructor.",
        organizations: [mockOrganizations[1], mockOrganizations[3]]
    ),
    User(
        displayName: "Rachel Green",
        profilePicture: "https://picsum.photos/150/150?random=309",
        description: "Animal rescue volunteer and adoption event organizer.",
        organizations: [mockOrganizations[3], mockOrganizations[6]]
    ),
    User(
        displayName: "Carlos Martinez",
        profilePicture: "https://picsum.photos/150/150?random=310",
        description: "Construction volunteer and home repair project leader.",
        organizations: [mockOrganizations[0], mockOrganizations[4], mockOrganizations[1]]
    ),
    User(
        displayName: "Lisa Wang",
        profilePicture: "https://picsum.photos/150/150?random=311",
        description: "Community garden coordinator and environmental educator.",
        organizations: [mockOrganizations[4], mockOrganizations[5], mockOrganizations[2]]
    )
]
