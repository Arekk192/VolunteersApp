//
//  ProfileView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    let participatedEvents: [Event] = mockEvents
    
    @State private var expandedEventIDs: Set<UUID> = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 25) {
                        if let image = user.profilePicture {
                            CacheImage(image, contentMode: .fill, aspectRatio: 1) {
                                Circle()
                                    .fill(.gray)
                                    .frame(width: 160, height: 160)
                            }
                            .frame(width: 160, height: 160)
                            .clipShape(.circle)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .font(.largeTitle)
                                .frame(width: 160, height: 160)
                                .clipShape(.circle)
                                .overlay {
                                    Circle()
                                        .stroke(.white, lineWidth: 2.5)
                                        .frame(width: 160, height: 160)
                                }
                        }
                        
                        VStack(spacing: 10) {
                            Text(user.displayName)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.primary)
                            
                            Text(user.isAdult ? "Dorosły/a" : "Małoletni/a")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(user.isAdult ? Color.blue.opacity(0.1) : Color.green.opacity(0.1))
                                )
                                .foregroundColor(user.isAdult ? .blue : .green)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("O mnie")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                        
                        Text(user.description)
                            .foregroundStyle(Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Przeszłe wydarzenia")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                        
                        ScrollView {
                            LazyVStack(spacing: 5) {
                                ForEach(participatedEvents) { event in
                                    ParticipatedEventRow(
                                        event: event,
                                        isExpanded: expandedEventIDs.contains(event.id)
                                    ) {
                                        if expandedEventIDs.contains(event.id) {
                                            expandedEventIDs.remove(event.id)
                                        } else {
                                            expandedEventIDs.insert(event.id)
                                        }
                                    }
                                }
                            }
                        }
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
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
    }
}

struct ParticipatedEventRow: View {
    var event: Event
    var isExpanded: Bool
    var onTap: () -> Void
    
    @Namespace private var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Text(event.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.primary)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .matchedGeometryEffect(id: "arrow\(event.id)", in: animation)
            }
            .padding(.vertical)
            .contentShape(.rect)
            .onTapGesture(perform: onTap)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Użytkownik wzorowo wywiązywał się z powierzonych zadań podczas organizacji wydarzenia. Jego zaangażowanie i profesjonalizm zasługują na uznanie.")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("Dodano: \(Date.now.formatted(as: "d MMM yyyy 'o' HH:mm"))")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 6)
                }
                .padding(.bottom)
                .transition(.opacity.combined(with: .scale(scale: 0.98, anchor: .top)))
            }
        }
    }
}

#Preview {
    ProfileView(user: mockUsers[0])
}


