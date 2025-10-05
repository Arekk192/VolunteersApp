//
//  QuestionsModalView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI

struct QuestionsModalView: View {
    @Environment(\.dismiss) private var dismiss
//    @StateObject private var viewModel = QAViewModel()
//    @State private var showingQuestionSheet = false
    @State private var newQuestion = ""
    
    @FocusState private var focused: Bool
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(mockQuestions) { item in
                        VStack(alignment: .leading, spacing: 10) {
                            // Question Section
                            Text(item.question)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            
                            // Answer Section
                            if let answer = item.answer {
                                Text(answer)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            // Question Author and Date
                            HStack {
                                HStack(spacing: 6) {
                                    if let image = item.questionAuthor.profilePicture {
                                        CacheImage(image, contentMode: .fill, aspectRatio: 1) {
                                            Circle()
                                                .fill(.gray)
                                                .frame(width: 25, height: 25)
                                        }
                                        .frame(width: 25, height: 25)
                                        .clipShape(.circle)
                                    }
                                    
                                    Text(item.questionAuthor.displayName)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                
                                Spacer()
                                
                                Text(item.date.formatted(as: "dd MMM yyyy 'o' HH:mm"))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 5)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                }
                .padding([.top, .horizontal])
                .padding(.bottom, 70)
            }
            .scrollDismissesKeyboard(.immediately)
            .overlay(alignment: .bottom) {
                InputBar(
                    placeholder: "Zadaj pytanie...",
                    text: $newQuestion,
                    isLoading: $isLoading,
                    focused: $focused
                ) {
                    print("")
                }
                .padding([.bottom, .horizontal])
            }
            .navigationTitle("Pytania i odpowiedzi")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }
}
