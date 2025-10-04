//
//  ProviderButton.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct ProviderButton<S: ButtonStyle>: View {
    let provider: Provider
    let style: S
    let iconSize: CGFloat
    let action: () -> Void

    init(
        for provider: Provider,
        style: S = RoundedRectButtonStyle(),
        iconSize: CGFloat = 24,
        action: @escaping () -> Void
    ) {
        self.provider = provider
        self.style = style
        self.iconSize = iconSize
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            provider.icon
                .frame(width: iconSize, height: iconSize)
        }
        .buttonStyle(style)
    }
}

struct RoundedRectButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 12
    var background: Color = Color(.systemBackground)
    var borderColor: Color = Color(.systemGray4)
    var borderWidth: CGFloat = 1
    var size: CGFloat = 50
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size, height: size)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
