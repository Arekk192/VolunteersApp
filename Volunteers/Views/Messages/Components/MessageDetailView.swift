//
//  MessageDetailView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct MessageDetailView: View {
    var user: User
    @ObservedObject var viewModel: MessagesViewModel
    @Binding var selectedUser: User?
    
    @FocusState private var inputFocused: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                LazyVStack(spacing: 10) {
                    if viewModel.isLoading && viewModel.messages.isEmpty {
                        ProgressView()
                            .padding()
                    }
                    
                    ForEach(viewModel.messages) { message in
                        MessageCardView(message: message)
                    }
                }
                .padding(15)
            }
            .scrollDismissesKeyboard(.immediately)
            .onChange(of: viewModel.messages) { oldValue, newValue in
                if let lastMessage = newValue.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .safeAreaBar(edge: .top) {
                HeaderView()
            }
            .safeAreaBar(edge: .bottom) {
                InputBar(
                    placeholder: "Wyślij wiadomość...",
                    text: $viewModel.messageText,
                    isLoading: $viewModel.isLoading,
                    focused: $inputFocused
                ) {
                    inputFocused = false
                    viewModel.sendMessage()
                }
                .padding([.horizontal, .bottom])
            }
            .alert("Błąd", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.clearError()
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        VStack(spacing: 6) {
            ZStack {
                Group {
                    if let imageUrl = user.profilePicture {
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
                .opacity(viewModel.animation.isExpantedCompletely ? 1 : 0)
                .onGeometryChange(for: CGRect.self) { proxy in
                    proxy.frame(in: .global)
                } action: { newValue in
                    viewModel.animation.destination = newValue
                }
            }
            .frame(width: 50, height: 50)
            
            Button {
                // Navigate to user profile
            } label: {
                HStack(spacing: 5) {
                    Text(user.displayName)
                        .font(.caption)
                        .foregroundStyle(Color.primary)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption2)
                        .foregroundStyle(Color.primary)
                }
                .padding(8)
                .glassEffect(.regular.interactive(), in: .capsule)
                .contentShape(.rect)
            }
            .padding(.top, -10)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 15)
        .padding(.top, -50)
    }
    
    @ViewBuilder
    private func MessageCardView(message: Message) -> some View {
        VStack(alignment: message.isReply ? .leading : .trailing, spacing: 4) {
            Text(message.text)
                .padding(12)
                .foregroundStyle(message.isReply ? Color.primary : .white)
                .background {
                    if message.isReply {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.gray.opacity(0.3))
                    } else {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.blue.gradient)
                    }
                }
        }
        .frame(maxWidth: 250, alignment: message.isReply ? .leading : .trailing)
        .frame(maxWidth: .infinity, alignment: message.isReply ? .leading : .trailing)
    }
}
