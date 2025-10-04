//
//  EventView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI
import MapKit

enum ParticipationState {
    case accepted
    case request
    case none
}

struct EventView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let event: Event
    @State private var position: MapCameraPosition
    @State private var participationState: ParticipationState = .none

    init(event: Event) {
        self.event = event
        _position = State(initialValue: .region(MKCoordinateRegion(
            center: event.location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ZStack(alignment: .bottom) {
                    if let firstImage = event.imageURLs.first,
                       let url = URL(string: firstImage) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity)
                                // .aspectRatio(3 / 4, contentMode: .fill)
                                .clipped()
                        } placeholder: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                
                                ProgressView()
                            }
                        }
                        .ignoresSafeArea(edges: .top)
                        .shadow(radius: 4)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 220)
                            .cornerRadius(16)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            )
                            .shadow(radius: 4)
                    }
                    
                    
                    LinearGradient(
                        colors: colorScheme == .dark
                        ? [Color.black.opacity(0), Color.black.opacity(1)]
                        : [Color.white.opacity(0), Color.white.opacity(1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 150)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Text(event.title)
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
                            
                            Text(event.startDate.formatted(as: "dd MMM HH:mm") +
                                 " - " +
                                 event.endDate.formatted(as: "dd MMM HH:mm")
                            )
                            .font(.body)
                            .fontWeight(.medium)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    ParticipationStateButton()
                    
                    Text(event.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                    
                    MapSection()
                }
                .padding([.horizontal, .bottom])
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Szczegóły wydarzenia")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    private func ParticipationStateButton() -> some View {
        Button {
            
        } label: {
            switch participationState {
            case .accepted:
                HStack {
                    Text("Potwierdzono obecność")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.green)
                }
            case .request:
                HStack {
                    Text("Oczekuje na potwierdzenie")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.orange)
                    
                    Image(systemName: "clock.badge.questionmark")
                        .font(.title3)
                        .foregroundStyle(.orange)
                }
            case .none:
                HStack {
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
    }
    
    @ViewBuilder
    private func MapSection() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Lokalizacja")
                .font(.headline)
            
            Map(position: $position) {
                Annotation(event.title, coordinate: event.location.coordinate) {
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
                let mapItem = event.location.toMapItem(name: event.title)
                mapItem.openInMaps()
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
