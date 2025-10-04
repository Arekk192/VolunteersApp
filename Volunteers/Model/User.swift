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
    var profileImage: String
    var backgroundImage: String
}


var users: [User] = [
    User(displayName: "iJustine", profilePicture: "", description: "Lorem ipsum", organizations: []),
    User(displayName: "Jenna", profilePicture: nil, description: "Lorem ipsum", organizations: []),
    User(displayName: "Anthony", profilePicture: nil, description: "Lorem ipsum", organizations: []),
    User(displayName: "Rick", profilePicture: "", description: "Lorem ipsum", organizations: []),
    User(displayName: "Kaviya", profilePicture: nil, description: "Lorem ipsum", organizations: [])
]
