//
//  Message.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct Message: Identifiable, Hashable {
    var id: UUID = .init()
    var text: String
    var isReply: Bool = false
    var sendAt: Date = Date()
}
