//
//  SettingsView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                isLoggedIn = false
            } label: {
                Text("Wyloguj się")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .glassEffect(.regular.interactive(), in: .capsule)
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Ustawienia")
    }
}
