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
        displayName: "Sarah Johnson",
        profilePicture: "https://picsum.photos/150/150?random=301",
        description: "Passionate about community building and affordable housing initiatives.",
        isAdult: true,
        organizations: [mockOrganizations[0], mockOrganizations[2]]
    ),
    User(
        displayName: "Marcus Chen",
        profilePicture: "https://picsum.photos/150/150?random=302",
        description: "Emergency response volunteer and disaster relief coordinator.",
        isAdult: false,
        organizations: [mockOrganizations[1], mockOrganizations[5]]
    ),
    User(
        displayName: "Elena Rodriguez",
        profilePicture: "https://picsum.photos/150/150?random=303",
        description: "Animal welfare advocate and shelter volunteer for 5+ years.",
        isAdult: false,
        organizations: [mockOrganizations[3]]
    ),
    User(
        displayName: "David Thompson",
        profilePicture: "https://picsum.photos/150/150?random=304",
        description: "Environmental activist organizing beach and park cleanups.",
        isAdult: true,
        organizations: [mockOrganizations[4], mockOrganizations[1]]
    ),
    User(
        displayName: "Priya Patel",
        profilePicture: "https://picsum.photos/150/150?random=305",
        description: "Youth mentor and education program coordinator.",
        isAdult: true,
        organizations: [mockOrganizations[5], mockOrganizations[2]]
    ),
    User(
        displayName: "James Wilson",
        profilePicture: "https://picsum.photos/150/150?random=306",
        description: "Senior care volunteer and community outreach specialist.",
        isAdult: false,
        organizations: [mockOrganizations[6], mockOrganizations[0]]
    ),
    User(
        displayName: "Maya Williams",
        profilePicture: "https://picsum.photos/150/150?random=307",
        description: "Food distribution coordinator and hunger relief advocate.",
        isAdult: true,
        organizations: [mockOrganizations[2], mockOrganizations[4]]
    ),
    User(
        displayName: "Alex Kim",
        profilePicture: "https://picsum.photos/150/150?random=308",
        description: "Disaster response team member and first aid instructor.",
        isAdult: false,
        organizations: [mockOrganizations[1], mockOrganizations[3]]
    ),
    User(
        displayName: "Rachel Green",
        profilePicture: "https://picsum.photos/150/150?random=309",
        description: "Animal rescue volunteer and adoption event organizer.",
        isAdult: false,
        organizations: [mockOrganizations[3], mockOrganizations[6]]
    ),
    User(
        displayName: "Carlos Martinez",
        profilePicture: "https://picsum.photos/150/150?random=310",
        description: "Construction volunteer and home repair project leader.",
        isAdult: true,
        organizations: [mockOrganizations[0], mockOrganizations[4], mockOrganizations[1]]
    ),
    User(
        displayName: "Lisa Wang",
        profilePicture: "https://picsum.photos/150/150?random=311",
        description: "Community garden coordinator and environmental educator.",
        isAdult: false,
        organizations: [mockOrganizations[4], mockOrganizations[5], mockOrganizations[2]]
    )
]
