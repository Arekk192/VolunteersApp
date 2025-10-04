//
//  TabItem.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

enum TabItem: String {
    case home = "Terminarz"
    case projects = "Projekty"
    case messages = "Wiadomości"
    case profile = "Profil"
    
    var tabImage: String {
        switch self {
        case .home:
            "house.fill"
        case .projects:
            "list.bullet.rectangle"
        case .messages:
            "message"
        case .profile:
            "person.fill"
        }
    }
}
