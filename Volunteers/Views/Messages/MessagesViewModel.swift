//
//  MessagesViewModel.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI
import Combine

@MainActor
class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var searchText: String = ""
    @Published var messageText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var animation: MessageAnimationConfiguration = .init()
    
    private let user: User
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User) {
        self.user = user
        setupSearchDebounce()
        loadMessages()
    }
    
    func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let newMessage = Message(
            id: UUID(),
            text: messageText.trimmingCharacters(in: .whitespacesAndNewlines),
            isReply: false,
            sendAt: Date.now
        )
        
        messages.append(newMessage)
        messageText = ""
        
        simulateReply(to: newMessage)
    }
    
    func loadMessages() {
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.messages = mockMessages
            self.isLoading = false
        }
    }
    
    func refreshMessages() {
        loadMessages()
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func setupAnimation() {
        
    }
        
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.filterMessages(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func filterMessages(with searchText: String) {
        guard !searchText.isEmpty else {
            loadMessages()
            return
        }
        
        let filteredMessages = mockMessages.filter { message in
            message.text.localizedCaseInsensitiveContains(searchText)
        }
        
        self.messages = filteredMessages
    }
    
    private func simulateReply(to message: Message) {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let replies = [
                "Dziękuję za wiadomość!",
                "Czy mogę w czymś pomóc?",
                "Bardzo się cieszę, że się odezwałeś/aś!",
                "Wkrótce odpowiem bardziej szczegółowo.",
                "To świetna wiadomość!"
            ]
            
            let randomReply = replies.randomElement() ?? "Dziękuję!"
            
            let replyMessage = Message(
                id: UUID(),
                text: randomReply,
                isReply: true,
                sendAt: Date.now
            )
            
            self.messages.append(replyMessage)
            self.isLoading = false
        }
    }
}
