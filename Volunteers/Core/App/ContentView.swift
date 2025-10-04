//
//  ContentView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

enum AuthenticationScreen {
    case Login
    case Register
}

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            AppContentView()
        } else {
            AppAuthenticationView()
        }
    }
}

struct AppContentView: View {
    @State private var currentTab: TabItem = .home
    
    var body: some View {
        TabView(selection: $currentTab) {
            Tab(TabItem.home.rawValue, systemImage: TabItem.home.tabImage, value: .home) {
                HomeView()
            }
            
            Tab(TabItem.projects.rawValue, systemImage: TabItem.projects.tabImage, value: .projects) {
                ProjectsView()
            }
            
            Tab(TabItem.messages.rawValue, systemImage: TabItem.messages.tabImage, value: .messages) {
                MessagesView()
            }
            
            Tab(TabItem.profile.rawValue, systemImage: TabItem.profile.tabImage, value: .profile) {
                ProfileView(user: mockUsers[0])
            }
        }
    }
}

struct AppAuthenticationView: View {
    @State private var currentScreen: AuthenticationScreen = .Login
    
    var body: some View {
        switch currentScreen {
        case .Login:
            LoginView(currentScreen: $currentScreen)
        case .Register:
            RegisterView(currentScreen: $currentScreen)
        }
    }
}

#Preview {
    ContentView()
}
