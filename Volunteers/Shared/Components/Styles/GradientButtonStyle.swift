//
//  GradientButtonStyle.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

public extension ButtonStyle where Self == GradientButtonStyle {
    static func gradient(
        isLoading: Bool = false,
        cornerRadius: CGFloat = 12,
        gradientColors: [Color] = [
            Color(red: 155 / 255, green: 47 / 255, blue: 77 / 255),
            Color(red: 147 / 255, green: 39 / 255, blue: 71 / 255),
        ],
        shadowColor: Color = .black.opacity(0.3),
        shadowRadius: CGFloat = 8,
        shadowYOffset: CGFloat = 4,
        pressedOpacity: Double = 0.8,
        pressedScale: CGFloat = 0.98
    ) -> GradientButtonStyle {
        GradientButtonStyle(
            isLoading: isLoading,
            cornerRadius: cornerRadius,
            gradientColors: gradientColors,
            shadowColor: shadowColor,
            shadowRadius: shadowRadius,
            shadowYOffset: shadowYOffset,
            pressedOpacity: pressedOpacity,
            pressedScale: pressedScale
        )
    }
}

public struct GradientButtonStyle: ButtonStyle {
    let isLoading: Bool
    let cornerRadius: CGFloat
    let gradientColors: [Color]
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowYOffset: CGFloat
    let pressedOpacity: Double
    let pressedScale: CGFloat
    
    init(
        isLoading: Bool = false,
        cornerRadius: CGFloat = 12,
        gradientColors: [Color] = [
            Color(red: 0.10, green: 0.45, blue: 0.89),
            Color(red: 0.78, green: 0.18, blue: 0.52)
        ],
        shadowColor: Color = .blue.opacity(0.3),
        shadowRadius: CGFloat = 4,
        shadowYOffset: CGFloat = 2,
        pressedOpacity: Double = 0.8,
        pressedScale: CGFloat = 0.98
    ) {
        self.isLoading = isLoading
        self.cornerRadius = cornerRadius
        self.gradientColors = gradientColors
        self.shadowColor = shadowColor
        self.shadowYOffset = shadowYOffset
        self.shadowRadius = shadowRadius
        self.pressedOpacity = pressedOpacity
        self.pressedScale = pressedScale
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Group {
            if isLoading {
                CircleLoader(size: 20, color: .white)
            } else {
                configuration.label
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            .linearGradient(
                colors: gradientColors,
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        )
        .cornerRadius(cornerRadius)
        .shadow(color: shadowColor, radius: shadowRadius, y: shadowYOffset)
        .opacity(configuration.isPressed ? pressedOpacity : 1.0)
        .scaleEffect(configuration.isPressed ? pressedScale : 1.0)
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}
