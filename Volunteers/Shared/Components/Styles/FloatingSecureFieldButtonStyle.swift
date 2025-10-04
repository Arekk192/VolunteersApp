//
//  FloatingSecureFieldButtonStyle.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

extension ButtonStyle where Self == FloatingSecureFieldButtonStyle {
    static func floatingSecureFieldStyle() -> FloatingSecureFieldButtonStyle {
        FloatingSecureFieldButtonStyle()
    }
}

struct FloatingSecureFieldButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isEnabled ? .secondary : .secondary.opacity(0.5))
            .contentShape(.rect)
    }
}
