//
//  MessagesView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct MessageAnimationConfiguration {
    var imageView: AnyView?
    var source: CGRect = .zero
    var destination: CGRect = .zero
    var isExpantedCompletely: Bool = false
    var activeId: UUID?
    
    static func createCacheImage(_ urlString: String?, placeholder: @escaping () -> some View) -> AnyView? {
        guard let urlString = urlString else { return nil }
        return AnyView(
            CacheImage(urlString, contentMode: .fill, aspectRatio: 1.0) {
                placeholder()
            }
        )
    }
    
    static func circularPlaceholder() -> some View {
        Circle()
            .fill(.gray)
            .frame(width: 45, height: 45)
    }
}

struct MessagesView: View {
    @StateObject private var viewModel = MessagesViewModel(user: mockUsers[0])
    @State private var selectedUser: User?
    
    @FocusState private var searchFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(mockUsers) { user in
                        UserMessageView(
                            user: user,
                            viewModel: viewModel
                        ) { rect in
                            viewModel.animation.source = rect
                            viewModel.animation.destination = rect
                            viewModel.animation.imageView = MessageAnimationConfiguration.createCacheImage(
                                user.profilePicture,
                                placeholder: { MessageAnimationConfiguration.circularPlaceholder() }
                            )
                            viewModel.animation.activeId = user.id
                            
                            selectedUser = user
                        }
                    }
                }
                .padding()
            }
            .safeAreaBar(edge: .top) {
                SearchBar(text: $viewModel.searchText, focused: $searchFocused)
                    .padding(.horizontal)
            }
            .navigationDestination(item: $selectedUser) { user in
                MessageDetailView(
                    user: user,
                    viewModel: viewModel,
                    selectedUser: $selectedUser
                )
            }
        }
        .overlay(alignment: .topLeading) {
            ZStack {
                if let imageView = viewModel.animation.imageView {
                    let destination = viewModel.animation.destination
                    
                    imageView
                        .frame(width: destination.width, height: destination.height)
                        .clipShape(.circle)
                        .offset(x: destination.minX, y: destination.minY)
                        .transition(.identity)
                        .onDisappear {
                            viewModel.animation = .init()
                        }
                }
            }
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: viewModel.animation.destination)
            .ignoresSafeArea()
            .opacity(viewModel.animation.isExpantedCompletely ? 0 : 1)
            .onChange(of: selectedUser == nil) { oldValue, newValue in
                if newValue {
                    viewModel.animation.isExpantedCompletely = false
                    
                    withAnimation(.easeInOut(duration: 0.35), completionCriteria: .logicallyComplete) {
                        viewModel.animation.destination = viewModel.animation.source
                    } completion: {
                        viewModel.animation.imageView = nil
                    }
                }
            }
        }
    }
}

#Preview {
    MessagesView()
}
