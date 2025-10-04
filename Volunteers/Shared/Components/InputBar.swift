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
    
    // Configuration
    private let font: Font = .system(size: 16)
    private let fontLineHeight: CGFloat = UIFont.systemFont(ofSize: 16).lineHeight
    private let minLines: Int = 1
    private let maxLines: Int = 8
    private let verticalPadding: CGFloat = 8
    private let leadingPadding: CGFloat = 15
    private let trailingPadding: CGFloat = 45
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(font)
                    .scrollContentBackground(.hidden)
                    .focused($focused)
                    .lineLimit(minLines...maxLines)
                    .frame(minHeight: calculateMinHeight(), maxHeight: calculateMaxHeight())
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading, leadingPadding - 4)
                    .padding(.trailing, trailingPadding - 4)
                    .padding(.vertical, verticalPadding - 4)
                    .glassEffect(.regular.interactive(),
                                 in: .rect(cornerRadius: 25, style: .continuous))
                    .disabled(isLoading)
                
                if text.isEmpty {
                    Text(placeholder)
                        .font(font)
                        .foregroundColor(Color.primary.opacity(0.6))
                        .padding(.leading, leadingPadding)
                        .padding(.vertical, verticalPadding + 4)
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
    }
    
    private func calculateMinHeight() -> CGFloat {
        let lineHeight = fontLineHeight
        return lineHeight * CGFloat(minLines) + (verticalPadding * 2) - 8
    }
    
    private func calculateMaxHeight() -> CGFloat {
        let lineHeight = fontLineHeight
        return lineHeight * CGFloat(maxLines - 1) + (verticalPadding * 2)
    }
}
