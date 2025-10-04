//
//  ProfileMessageView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//


import SwiftUI

struct UserMessageView: View {
    var user: User
    @Binding var configuration: MessageAnimationConfiguration
    var onClick: (CGRect) -> Void
    
    @State private var viewRect: CGRect = .zero
    
    var body: some View {
        Button {
            onClick(viewRect)
        } label: {
            HStack(spacing: 12) {
                Image(user.profilePicture ?? "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(.circle)
                    .opacity(configuration.activeId == user.id ? 0 : 1)
                    .onGeometryChange(for: CGRect.self) { proxy in
                        proxy.frame(in: .global)
                    } action: { newValue in
                        viewRect = newValue
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.displayName)
                        .font(.callout)
                        .foregroundStyle(Color.primary)
                    
                    Text("user.lastMessage")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .contentShape(.rect)
        }
    }
}
