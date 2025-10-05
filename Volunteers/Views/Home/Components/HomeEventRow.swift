//
//  HomeEventRow.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct HomeEventRow: View {
    let event: Event
    @State private var geocodedLocation: String = ""
    
    init(_ event: Event) {
        self.event = event
    }
    
    var body: some View {
        NavigationLink(value: event) {
            HStack(spacing: 15) {
                if let image = event.imageURLs.first {
                    CacheImage(image, contentMode: .fill, aspectRatio: 1) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .frame(width: 80, height: 80)
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(cornerRadius: 10))
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .aspectRatio(1.0, contentMode: .fill)
                        .frame(width: 80, height: 80)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Image(systemName: "clock")
                            .font(.caption)
                        
                        Text("\(event.startDate.formatted(as: "dd MMM hh:mm")) - \(event.endDate.formatted(as: "dd MMM hh:mm"))")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "location")
                            .font(.caption)
                        
                        Text(geocodedLocation)
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(10)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
        }
        .task {
            do {
                if let location = event.location {
                    geocodedLocation = try await location.toAddress()
                }
            } catch {
                geocodedLocation = ""
            }
        }
    }
}
