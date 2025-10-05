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
    @State private var showingAllEvents = false
    @State private var selectedEvent: Event?
    @State private var showingEventDetail = false
    
    var displayedEvents: [Event] {
        Array(participatedEvents.prefix(3))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Header Section
                    VStack(spacing: 20) {
                        ProfileAvatarView(user: user)
                        
                        VStack(spacing: 8) {
                            Text(user.displayName)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.primary)
                            
                            StatusBadge(isAdult: user.isAdult)
                        }
                    }
                    .padding(.top, 10)
                    
                    // About Section
                    AboutSection(description: user.description)
                    
                    // Events Section
                    EventsSection(
                        displayedEvents: displayedEvents,
                        totalEventsCount: participatedEvents.count,
                        expandedEventIDs: $expandedEventIDs,
                        selectedEvent: $selectedEvent,
                        showingAllEvents: $showingAllEvents,
                        showingEventDetail: $showingEventDetail
                    )
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Twój profil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showingAllEvents) {
                AllEventsView(
                    events: participatedEvents,
                    expandedEventIDs: $expandedEventIDs,
                    selectedEvent: $selectedEvent,
                    showingEventDetail: $showingEventDetail
                )
            }
            .sheet(isPresented: $showingEventDetail) {
                if let event = selectedEvent {
                    EventDetailView(event: event)
                }
            }
        }
    }
}

// MARK: - Profile Avatar
struct ProfileAvatarView: View {
    let user: User
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 120, height: 120)
            
            if let image = user.profilePicture {
                CacheImage(image, contentMode: .fill, aspectRatio: 1) {
                    Circle()
                        .fill(.gray)
                }
                .frame(width: 120, height: 120)
                .clipShape(.circle)
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.secondary)
            }
        }
        .overlay(
            Circle()
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
    }
}

// MARK: - Status Badge
struct StatusBadge: View {
    let isAdult: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(isAdult ? Color.blue : Color.green)
                .frame(width: 6, height: 6)
            
            Text(isAdult ? "Dorosły/a" : "Małoletni/a")
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(isAdult ? Color.blue.opacity(0.1) : Color.green.opacity(0.1))
        )
        .foregroundColor(isAdult ? .blue : .green)
    }
}

// MARK: - About Section
struct AboutSection: View {
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "O mnie", icon: "person.text.rectangle")
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Events Section
struct EventsSection: View {
    let displayedEvents: [Event]
    let totalEventsCount: Int
    @Binding var expandedEventIDs: Set<UUID>
    @Binding var selectedEvent: Event?
    @Binding var showingAllEvents: Bool
    @Binding var showingEventDetail: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                SectionHeader(title: "Przeszłe wydarzenia", icon: "calendar")
                
                Spacer()
                
                if totalEventsCount > 3 {
                    Button(action: { showingAllEvents = true }) {
                        HStack(spacing: 4) {
                            Text("Wszystkie")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            
            LazyVStack(spacing: 8) {
                ForEach(displayedEvents) { event in
                    EventCard(
                        event: event,
                        isExpanded: expandedEventIDs.contains(event.id),
                        onTap: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                if expandedEventIDs.contains(event.id) {
                                    expandedEventIDs.remove(event.id)
                                } else {
                                    expandedEventIDs.insert(event.id)
                                }
                            }
                        },
                        onDetailTap: {
                            selectedEvent = event
                            showingEventDetail = true
                        }
                    )
                }
            }
            
            if totalEventsCount == 0 {
                EmptyEventsView()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Section Header
struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
                .frame(width: 16)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.primary)
        }
    }
}

// MARK: - Event Card
struct EventCard: View {
    let event: Event
    let isExpanded: Bool
    let onTap: () -> Void
    let onDetailTap: () -> Void
    
    @Namespace private var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                // Event Icon
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "calendar.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
                
                // Event Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text("\(event.startDate.formatted(as: "d MMM yyyy"))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Expand Button
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .matchedGeometryEffect(id: "arrow\(event.id)", in: animation)
            }
            .padding()
            .contentShape(.rect)
            .onTapGesture(perform: onTap)
            
            // Expanded Content
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.orange)
                            
                            Text("Pozytywna opinia")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        
                        Text(event.feedback?.comment ?? "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineSpacing(2)
                        
                        Text("Dodano: \(Date.now.formatted(as: "d MMM yyyy"))")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .transition(.blurReplace.combined(with: .move(edge: .top)))
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
    }
}

// MARK: - Empty State
struct EmptyEventsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 32))
                .foregroundColor(.secondary)
            
            Text("Brak wydarzeń")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text("Weź udział w wydarzeniach, aby zobaczyć je tutaj")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
    }
}

// MARK: - All Events View
struct AllEventsView: View {
    let events: [Event]
    @Binding var expandedEventIDs: Set<UUID>
    @Binding var selectedEvent: Event?
    @Binding var showingEventDetail: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(events) { event in
                        EventCard(
                            event: event,
                            isExpanded: expandedEventIDs.contains(event.id),
                            onTap: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    if expandedEventIDs.contains(event.id) {
                                        expandedEventIDs.remove(event.id)
                                    } else {
                                        expandedEventIDs.insert(event.id)
                                    }
                                }
                            },
                            onDetailTap: {
                                selectedEvent = event
                                showingEventDetail = true
                            }
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Wszystkie wydarzenia")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

// MARK: - Event Detail View
struct EventDetailView: View {
    let event: Event
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Image(systemName: "calendar.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.blue)
                                )
                            
                            Spacer()
                            
                            Label("Zakończone", systemImage: "checkmark.circle.fill")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.green)
                                .padding(8)
                                .background(Color.green.opacity(0.1))
                                .clipShape(Capsule())
                        }
                        
                        Text(event.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text(event.startDate.formatted(as: "EEEE, d MMMM yyyy"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Feedback Section
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Opinia organizatora", icon: "star.fill")
                            .foregroundColor(.orange)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.green)
                                
                                Text("Pozytywna opinia")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            
                            Text("Użytkownik wzorowo wywiązywał się z powierzonych zadań podczas organizacji wydarzenia. Jego zaangażowanie i profesjonalizm zasługują na uznanie.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineSpacing(2)
                            
                            Text("Dodano: \(Date.now.formatted(as: "d MMM yyyy 'o' HH:mm"))")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Szczegóły wydarzenia")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Gotowe") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ProfileView(user: mockUsers[0])
}
