//
//  InputBar.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct InputBar: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isLoading: Bool
    @FocusState.Binding var focused: Bool
    var onSend: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.system(size: 16))
                    .scrollContentBackground(.hidden)
                    .focused($focused)
                    .lineLimit(1...8)
                    .frame(minHeight: 24, maxHeight: 168)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading, 11)
                    .padding(.trailing, 41)
                    .padding(.vertical, 4)
                    .disabled(isLoading)
                
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 16))
                        .foregroundColor(Color.primary.opacity(0.6))
                        .padding(.leading, 15)
                        .padding(.vertical, 12)
                        .allowsHitTesting(false)
                }
            }
            .clipShape(.rect(cornerRadius: 25, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 0.5)
            )

            Button {
                onSend()
                focused = false
            } label: {
                Image(systemName: "arrow.up")
                    .font(.system(size: 16, weight: .bold))
                    .padding(6)
                    .foregroundStyle(Color.primary)
            }
            .glassEffect(
                .regular.tint(text.isEmpty ? Color.secondary.opacity(0.4) : .blue).interactive(),
                in: .capsule
            )
            .disabled(text.isEmpty || isLoading)
            .padding(.bottom, 8)
            .padding(.trailing, 6)
        }
        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 25))
    }
}
