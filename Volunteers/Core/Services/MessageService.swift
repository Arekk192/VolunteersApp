//
//  MessageService.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI

protocol MessageServiceProtocol {
    func sendMessage() async throws
    func loadMessages(page: Int, limit: Int, conversationId: UUID) async throws -> [Message]
}

//class MockMessageService: MessageServiceProtocol {
//   
//}
