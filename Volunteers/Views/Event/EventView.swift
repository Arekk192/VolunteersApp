//
//  EventView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI
import MapKit

enum ParticipationState: Codable, Hashable {
    case accepted
    case request
    case none
}

struct EventView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel: EventViewModel

    init(event: Event) {
        _viewModel = StateObject(wrappedValue: EventViewModel(event: event))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    if let image = viewModel.event.imageURLs.first {
                        CacheImage(image, contentMode: .fill, aspectRatio: 3 / 4) {
                            Image(systemName: "photo")
                        }
                        .aspectRatio(3 / 4, contentMode: .fill)
                        .ignoresSafeArea(edges: .top)
                        .shadow(color: colorScheme == .dark ? .black : .white, radius: 4)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .aspectRatio(3 / 4, contentMode: .fill)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            )
                            .shadow(color: colorScheme == .dark ? .black : .white, radius: 4)
                    }
                }
                .overlay(alignment: .bottom) {
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            colors: colorScheme == .dark
                            ? [Color.black.opacity(0), Color.black.opacity(1)]
                            : [Color.white.opacity(0), Color.white.opacity(1)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 100)
                        
                        VStack(spacing: 15) {
                            HStack {
                                Text(viewModel.event.title)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.primary)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 10) {
                                Image(systemName: "calendar")
                                    .foregroundColor(Color.primary)
                                    .font(.body)
                                    .fontWeight(.medium)
                                
                                Text(viewModel.eventDates)
                                .font(.body)
                                .fontWeight(.medium)
                                
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .bottom])
                    }
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    ParticipationStateButton()
                    
                    Text(viewModel.event.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                    
                    QuestionsSection()
                    
                    if let location = viewModel.event.location {
                        MapSection(location: location)
                    }
                }
                .padding([.horizontal, .bottom])
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Szczegóły wydarzenia")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $viewModel.showQuestionsModal) {
            QuestionsModalView()
        }
        .sheet(isPresented: $viewModel.showParticipationModal) {
            ParticipationConfirmationModal(
                isPresented: $viewModel.showParticipationModal,
                participationState: viewModel.participationState,
                onConfirm: {
                    Task(priority: .high) {
                        await viewModel.handleParticipation()
                    }
                }
            )
        }
        .onDisappear {
            viewModel.cancelOperations()
        }
    }
    
    @ViewBuilder
    private func ParticipationStateButton() -> some View {
        Button {
            if viewModel.participationState == .none {
                viewModel.showParticipationModal = true
            } else {
                Task(priority: .high) {
                    await viewModel.handleParticipation()
                }
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    CircleLoader(size: 20, color: {
                        switch viewModel.participationState {
                        case .accepted: .green
                        case .request: .orange
                        case .none: .blue
                        }
                    }())
                    .scaleEffect(0.8)
                } else {
                    switch viewModel.participationState {
                    case .accepted:
                        Text("Potwierdzono obecność")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.green)
                    case .request:
                        Text("Oczekuje na potwierdzenie")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                        
                        Image(systemName: "clock.badge.questionmark")
                            .font(.title3)
                            .foregroundStyle(.orange)
                    case .none:
                        Text("Weź udział")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                        
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.title3)
                            .foregroundStyle(.blue)
                    }
                }
            }
            .frame(height: 25)
        }
        .disabled(viewModel.isLoading)
    }
    
    @ViewBuilder
    private func QuestionsSection() -> some View {
        Button {
            viewModel.showQuestionsModal = true
        } label: {
            VStack(alignment: .leading, spacing: 15) {
                Text("Pytania i odpowiedzi")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(mockQuestions.prefix(3))) { item in
                        Text("• \(item.question)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                if mockQuestions.count > 3 {
                    Button {
                        viewModel.showQuestionsModal = true
                    } label: {
                        HStack {
                            Text("Pokaż wszystkie \(mockQuestions.count) pytań")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.blue)
                        .padding(.top, 5)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
        
    @ViewBuilder
    private func MapSection(location: EventLocation) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Lokalizacja")
                .font(.headline)
            
            Map(position: $viewModel.position) {
                Annotation(viewModel.event.title, coordinate: location.coordinate) {
                    ZStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 14, height: 14)
                        
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 2)
                            .frame(width: 14, height: 14)
                    }
                    .shadow(radius: 3)
                }
            }
            .mapControls {
                MapCompass()
            }
            .frame(height: 300)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 4)
            
            Button {
                location.toMapItem(name: viewModel.event.title).openInMaps()
            } label: {
                HStack(spacing: 5) {
                    Text("Znajdź trasę")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Image(systemName: "arrow.right")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .glassEffect(.regular.interactive(), in: .capsule)
            }
        }
    }
}


#Preview {
    EventView(event: mockEvents[0])
}

struct ParticipationConfirmationModal: View {
    @Binding var isPresented: Bool
    let participationState: ParticipationState
    let onConfirm: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: iconName)
                    .font(.system(size: 60))
                    .foregroundColor(iconColor)
                    .symbolEffect(.bounce, value: isPresented)
                
                VStack(spacing: 12) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text(message)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                
                VStack(spacing: 12) {
                    Button {
                        onConfirm()
                        isPresented = false
                    } label: {
                        Text(confirmButtonText)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(buttonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Button("Anuluj", role: .cancel) {
                        isPresented = false
                    }
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                }
            }
            .padding(25)
            .navigationTitle("Potwierdzenie udziału")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Zamknij") {
                        isPresented = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
        .presentationCornerRadius(20)
    }
    
    private var title: String {
        switch participationState {
        case .none:
            return "Weź udział w wydarzeniu"
        case .request:
            return "Anuluj zgłoszenie"
        case .accepted:
            return "Rezygnacja z udziału"
        }
    }
    
    private var message: String {
        switch participationState {
        case .none:
            return "Czy na pewno chcesz zgłosić swój udział w tym wydarzeniu? Organizator zostanie powiadomiony o Twoim zgłoszeniu."
        case .request:
            return "Twoje zgłoszenie oczekuje na potwierdzenie. Czy na pewno chcesz je wycofać?"
        case .accepted:
            return "Twoja obecność została potwierdzona. Czy na pewno chcesz zrezygnować z udziału w wydarzeniu?"
        }
    }
    
    private var iconName: String {
        switch participationState {
        case .none: return "person.crop.circle.badge.plus"
        case .request: return "clock.badge.questionmark"
        case .accepted: return "checkmark.circle.fill"
        }
    }
    
    private var iconColor: Color {
        switch participationState {
        case .none: return .blue
        case .request: return .orange
        case .accepted: return .green
        }
    }
    
    private var confirmButtonText: String {
        switch participationState {
        case .none: return "Potwierdź udział"
        case .request, .accepted: return "Tak, kontynuuj"
        }
    }
    
    private var buttonColor: Color {
        switch participationState {
        case .none: return .blue
        case .request, .accepted: return .red
        }
    }
}
