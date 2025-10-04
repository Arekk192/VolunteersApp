//
//  FloatingLabelTextFieldStyle.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct FloatingLabelTextFieldStyle: TextFieldStyle {
    let systemImage: String
    private let isSecure: Bool
    @FocusState private var isFocused: Bool
    
    init(systemImage: String, isSecure: Bool = false) {
        self.systemImage = systemImage
        self.isSecure = isSecure
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 12) {
                Image(systemName: systemImage)
                    .foregroundColor(isFocused ? .blue : .secondary)
                    .frame(width: 20)
                
                configuration
                    .focused($isFocused)
                    .foregroundColor(.primary)
            }
            .padding(.leading, 16)
            .padding(.trailing, isSecure ? 36 : 16)
            .padding(.vertical, 14)
            .frame(height: 50)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.blue : Color(.systemGray4), lineWidth: 1.5)
            )
            .shadow(color: isFocused ? .blue.opacity(0.1) : .clear, radius: 4)
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

extension TextFieldStyle where Self == FloatingLabelTextFieldStyle {
    static func floatingLabel(systemImage: String, isSecure: Bool = false) -> FloatingLabelTextFieldStyle {
        FloatingLabelTextFieldStyle(systemImage: systemImage, isSecure: isSecure)
    }
}
