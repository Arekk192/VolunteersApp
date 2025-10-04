//
//  ContentView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct ContentView: View {
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
                ProfileView(
                    user: User(
                        displayName: "Anna Kowalska",
                        description: "dasdasdas asd asd",
                        organizations: []
                    )
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
