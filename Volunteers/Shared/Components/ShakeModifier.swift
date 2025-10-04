//
//  ShakeModifier.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct ShakeModifier<T: Equatable>: ViewModifier {
    let trigger: T
    
    init(_ trigger: T) {
        self.trigger = trigger
    }
    
    func body(content: Content) -> some View {
        content
            .keyframeAnimator(initialValue: 0.0, trigger: trigger) { content, value in
                content.offset(x: value)
            } keyframes: { _ in
                KeyframeTrack(\.self) {
                    LinearKeyframe(0.0, duration: 0.02)
                    
                    SpringKeyframe(10.0, duration: 0.10)
                    SpringKeyframe(-8.0, duration: 0.097)
                    
                    SpringKeyframe(8.0, duration: 0.107)
                    SpringKeyframe(-9.0, duration: 0.09)
                    
                    SpringKeyframe(2.0, duration: 0.06)
                    SpringKeyframe(-1.0, duration: 0.05)
                    
                    SpringKeyframe(0.5, duration: 0.04)
                    SpringKeyframe(0.0, duration: 0.12)
                }
            }
    }
}

extension View {
    func shaking(on trigger: some Equatable) -> some View {
        modifier(ShakeModifier(trigger))
    }
}
