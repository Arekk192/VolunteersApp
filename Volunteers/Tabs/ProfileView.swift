//
//  ProfileView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 25) {
                        Circle()
                            .fill(.green.gradient)
                            .frame(width: 160, height: 160)
                        
                        VStack(spacing: 10) {
                            Text(user.displayName)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.primary)
                            
                            Text("Uczennica")
                                .font(.body)
                                .foregroundStyle(Color.primary)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("O mnie")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                        
                        Text(user.description)
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Twój profil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edycja", systemImage: "gearshape") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(
        user: User(
            displayName: "",
            description: "Lorem ipsum",
            organizations: []
        )
    )
}


