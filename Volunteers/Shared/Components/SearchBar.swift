//
//  SearchBar.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState.Binding var focused: Bool
    
    var body: some View {
        GlassEffectContainer(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                TextField("Wyszukaj", text: $text)
                    .submitLabel(.search)
                    .focused($focused)
                
                Image(systemName: "xmark.circle.fill")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .opacity(text.isEmpty ? 0 : 1)
                    .animation(.snappy(duration: 0.07), value: text.isEmpty)
                    .onTapGesture {
                        text = ""
                        focused = false
                    }
            }
            .padding(.horizontal, 15)
            .frame(height: 45)
            .glassEffect(.regular.interactive(), in: .capsule)
        }
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: focused)
    }
}
