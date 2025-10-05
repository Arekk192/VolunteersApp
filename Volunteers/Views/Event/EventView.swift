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
                        .shadow(radius: 4)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .aspectRatio(3 / 4, contentMode: .fill)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            )
                            .shadow(radius: 4)
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
    }
    
    @ViewBuilder
    private func ParticipationStateButton() -> some View {
        Button {
            Task {
                await viewModel.handleParticipation()
            }
        } label: {
            let buttonData = viewModel.getParticipationButtonData()
            
            HStack {
                Text(buttonData.title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(buttonData.color)
                
                Image(systemName: buttonData.icon)
                    .font(.title3)
                    .foregroundStyle(buttonData.color)
            }
        }
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
