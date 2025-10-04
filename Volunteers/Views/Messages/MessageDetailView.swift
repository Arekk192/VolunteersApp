//
//  MessageDetailView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct MessageDetailView: View {
    var user: User
    @Binding var configuration: MessageAnimationConfiguration
    @Binding var selectedUser: User?
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(messages) { message in
                    MessageCardView(message: message)
                }
            }
            .padding(15)
        }
        .safeAreaInset(edge: .top) {
            HeaderView()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                configuration.isExpantedCompletely = true
            }
        }
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        VStack(spacing: 6) {
            ZStack {
                if let selectedUser {
                    Group {
                        if let imageUrl = selectedUser.profilePicture {
                            CacheImage(imageUrl, contentMode: .fill, aspectRatio: 1.0) {
                                MessageAnimationConfiguration.circularPlaceholder()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                        } else {
                            MessageAnimationConfiguration.circularPlaceholder()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .opacity(configuration.isExpantedCompletely ? 1 : 0)
                    .onGeometryChange(for: CGRect.self) { proxy in
                        proxy.frame(in: .global)
                    } action: { newValue in
                        configuration.destination = newValue
                    }
                }
            }
            .frame(width: 50, height: 50)
            
            Button {
                
            } label: {
                HStack(spacing: 2) {
                    Text(user.displayName)
                        .font(.caption)
                        .foregroundStyle(Color.primary)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption2)
                        .foregroundStyle(Color.primary)
                }
                .glassEffect(.regular.interactive(), in: .capsule)
                .contentShape(.rect)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 15)
        .padding(.top, -50)
    }
    
    @ViewBuilder
    private func MessageCardView(message: Message) -> some View {
        Text(message.text)
            .padding(10)
            .foregroundStyle(message.isReply ? Color.primary : .white)
            .background {
                if message.isReply {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.3))
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.blue.gradient)
                }
            }
            .frame(maxWidth: 250, alignment: message.isReply ? .leading : .trailing)
            .frame(maxWidth: .infinity, alignment: message.isReply ? .leading : .trailing)
    }
}
