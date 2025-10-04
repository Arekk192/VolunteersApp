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
    
    @State private var configuration: MessageAnimationConfiguration = .init()
    @State private var selectedUser: User?
    
    @State private var searchText: String = ""
    @FocusState private var searchFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(mockUsers) { user in
                        UserMessageView(user: user, configuration: $configuration) { rect in
                            configuration.source = rect
                            configuration.destination = rect
                            configuration.imageView = MessageAnimationConfiguration.createCacheImage(
                                user.profilePicture,
                                placeholder: { MessageAnimationConfiguration.circularPlaceholder() }
                            )
                            configuration.activeId = user.id
                            
                            selectedUser = user
                        }
                    }
                }
                .padding(.top, 65)
                .padding(.horizontal)
            }
            .overlay(alignment: .top) {
                SearchBar(text: $searchText, focused: $searchFocused)
                    .padding(.horizontal)
            }
            .navigationDestination(item: $selectedUser) { user in
                MessageDetailView(
                    user: user,
                    configuration: $configuration,
                    selectedUser: $selectedUser
                )
            }
        }
        .overlay(alignment: .topLeading) {
            ZStack {
                if let imageView = configuration.imageView {
                    let destination = configuration.destination
                    
                    imageView
                        .frame(width: destination.width, height: destination.height)
                        .clipShape(.circle)
                        .offset(x: destination.minX, y: destination.minY)
                        .transition(.identity)
                        .onDisappear {
                            configuration = .init()
                        }
                }
            }
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: configuration.destination)
            .ignoresSafeArea()
            .opacity(configuration.isExpantedCompletely ? 0 : 1)
            .onChange(of: selectedUser == nil) { oldValue, newValue in
                if newValue {
                    configuration.isExpantedCompletely = false
                    
                    withAnimation(.easeInOut(duration: 0.35), completionCriteria: .logicallyComplete) {
                        configuration.destination = configuration.source
                    } completion: {
                        configuration.imageView = nil
                    }
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @FocusState.Binding var focused: Bool
    
    var body: some View {
        GlassEffectContainer(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                TextField("Wyszukaj", text: $text)
                    .submitLabel(.search)
                    .focused($focused)
                
                Image(systemName: "xmark.circle.fill")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .opacity(text.isEmpty ? 0 : 1)
                    .animation(.snappy(duration: 0.07), value: text.isEmpty)
                    .onTapGesture {
                        text = ""
                        focused = false
                    }
            }
            .padding(.horizontal, 15)
            .frame(height: 45)
            .glassEffect(.regular.interactive(), in: .capsule)
        }
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: focused)
    }
}

#Preview {
    MessagesView()
}
