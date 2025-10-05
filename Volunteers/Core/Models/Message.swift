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
    
//    var timeString: String {
//        sendAt.formatted(as: "")
//    }
}

let mockMessages: [Message] = [
    .init(text: text1, isReply: true),
    .init(text: text2),
    .init(text: text3),
    .init(text: text4, isReply: true),
    .init(text: text5, isReply: true),
    .init(text: text6),
    .init(text: text1),
    .init(text: text2, isReply: true),
    .init(text: text3),
    .init(text: text4, isReply: true),
    .init(text: text5),
    .init(text: text6, isReply: true),
    .init(text: text1),
    .init(text: text2),
    .init(text: text3, isReply: true),
    .init(text: text4, isReply: true),
    .init(text: text5, isReply: true),
    .init(text: text6),
]

var text1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
var text2 = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
var text3 = "When an unknown printer took a galley of type and scrambled it to make a type specimen book."
var text4 = "It has survived not only five centuries, but also the leap into electronic typesetting."
var text5 = "Contrary to popular belief, Lorem Ipsum is not simply random text."
var text6 = "It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."
