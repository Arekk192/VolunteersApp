//
//  Question.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI

struct Question: Identifiable {
    let id = UUID()
    let question: String
    let answer: String?
    let questionAuthor: User
    let answerAuthor: Organization?
    let date: Date
    let isAnswered: Bool
    
    init(question: String, questionAuthor: User, date: Date = Date()) {
        self.question = question
        self.answer = nil
        self.questionAuthor = questionAuthor
        self.answerAuthor = nil
        self.date = date
        self.isAnswered = false
    }
    
    init(question: String, answer: String, questionAuthor: User, answerAuthor: Organization, date: Date) {
        self.question = question
        self.answer = answer
        self.questionAuthor = questionAuthor
        self.answerAuthor = answerAuthor
        self.date = date
        self.isAnswered = true
    }
}

var mockQuestions = [
    Question(
        question: "Czy wydarzenie jest darmowe?",
        answer: "Tak, udział w wydarzeniu jest całkowicie darmowy dla wszystkich uczestników. Koszty organizacji pokrywają sponsorzy.",
        questionAuthor: mockUsers[0],
        answerAuthor: mockOrganizations[0],
        date: Date().addingTimeInterval(-86400 * 2)
    ),
    Question(
        question: "Czy trzeba zabrać ze sobą jakieś materiały?",
        answer: "Wszystkie niezbędne materiały zapewniamy na miejscu. Możesz zabrać własny laptop jeśli wolisz pracować na swoim sprzęcie, ale nie jest to wymagane.",
        questionAuthor: mockUsers[0],
        answerAuthor: mockOrganizations[0],
        date: Date().addingTimeInterval(-86400 * 1)
    ),
    Question(
        question: "Jaki jest poziom zaawansowania wymagany do uczestnictwa?",
        questionAuthor: mockUsers[1],
        date: Date().addingTimeInterval(-3600 * 12)
    ),
    Question(
        question: "Czy będzie dostępny catering?",
        questionAuthor: mockUsers[0],
        date: Date().addingTimeInterval(-3600 * 6)
    )
]
