//
//  CircleLoader.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct CircleLoader: View {
    let size: CGFloat
    let color: Color
    
    @State private var isAnimating = false
    @State private var trimStart: CGFloat = 0.0
    @State private var trimEnd: CGFloat = 0.15
    
    var body: some View {
        Circle()
            .trim(from: trimStart, to: trimEnd)
            .stroke(
                color,
                style: StrokeStyle(lineWidth: size / 6, lineCap: .round, lineJoin: .round)
            )
            .frame(width: size, height: size)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .onAppear {
                withAnimation(Animation.linear(duration: 0.65).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
                
                withAnimation(Animation.easeInOut(duration: 1.25).delay(0.375).repeatForever(autoreverses: true)) {
                    trimStart = 0.2
                    trimEnd = 0.75
                }
            }
    }
}
