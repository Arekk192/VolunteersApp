//
//  EventView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI
import MapKit

enum ParticipationState {
    case accepted
    case request
    case none
}

struct QAItem: Identifiable {
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

var mockQAItems = [
    QAItem(
        question: "Czy wydarzenie jest darmowe?",
        answer: "Tak, udział w wydarzeniu jest całkowicie darmowy dla wszystkich uczestników. Koszty organizacji pokrywają sponsorzy.",
        questionAuthor: mockUsers[0],
        answerAuthor: mockOrganizations[0],
        date: Date().addingTimeInterval(-86400 * 2)
    ),
    QAItem(
        question: "Czy trzeba zabrać ze sobą jakieś materiały?",
        answer: "Wszystkie niezbędne materiały zapewniamy na miejscu. Możesz zabrać własny laptop jeśli wolisz pracować na swoim sprzęcie, ale nie jest to wymagane.",
        questionAuthor: mockUsers[0],
        answerAuthor: mockOrganizations[0],
        date: Date().addingTimeInterval(-86400 * 1)
    ),
    QAItem(
        question: "Jaki jest poziom zaawansowania wymagany do uczestnictwa?",
        questionAuthor: mockUsers[1],
        date: Date().addingTimeInterval(-3600 * 12)
    ),
    QAItem(
        question: "Czy będzie dostępny catering?",
        questionAuthor: mockUsers[0],
        date: Date().addingTimeInterval(-3600 * 6)
    )
]

struct EventView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let event: Event
    @State private var position: MapCameraPosition
    @State private var participationState: ParticipationState = .none
    @State private var showQAModal = false

    init(event: Event) {
        self.event = event
        
        if let location = event.location {
            _position = State(initialValue: .region(MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )))
        } else {
            _position = State(initialValue: .automatic)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    if let image = event.imageURLs.first {
                        CacheImage(image, contentMode: .fill, aspectRatio: 3 / 4) {
                            Image(systemName: "photo")
                        }
                        .aspectRatio(3 / 4, contentMode: .fill)
                        .ignoresSafeArea(edges: .top)
                        .shadow(radius: 4)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .aspectRatio(3 / 4, contentMode: .fill)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            )
                            .shadow(radius: 4)
                    }
                }
                .overlay(alignment: .bottom) {
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            colors: colorScheme == .dark
                            ? [Color.black.opacity(0), Color.black.opacity(1)]
                            : [Color.white.opacity(0), Color.white.opacity(1)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 100)
                        
                        VStack(spacing: 15) {
                            HStack {
                                Text(event.title)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.primary)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 10) {
                                Image(systemName: "calendar")
                                    .foregroundColor(Color.primary)
                                    .font(.body)
                                    .fontWeight(.medium)
                                
                                Text(event.startDate.formatted(as: "dd MMM HH:mm") +
                                     " - " +
                                     event.endDate.formatted(as: "dd MMM HH:mm")
                                )
                                .font(.body)
                                .fontWeight(.medium)
                                
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .bottom])
                    }
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    ParticipationStateButton()
                    
                    Text(event.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                    
                    QuestionsSection()
                    
                    if let location = event.location {
                        MapSection(location: location)
                    }
                }
                .padding([.horizontal, .bottom])
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Szczegóły wydarzenia")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $showQAModal) {
            QuestionsModalView()
        }
    }
    
    @ViewBuilder
    private func ParticipationStateButton() -> some View {
        Button {
            
        } label: {
            switch participationState {
            case .accepted:
                HStack {
                    Text("Potwierdzono obecność")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.green)
                }
            case .request:
                HStack {
                    Text("Oczekuje na potwierdzenie")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.orange)
                    
                    Image(systemName: "clock.badge.questionmark")
                        .font(.title3)
                        .foregroundStyle(.orange)
                }
            case .none:
                HStack {
                    Text("Weź udział")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                    
                    Image(systemName: "person.crop.circle.badge.plus")
                        .font(.title3)
                        .foregroundStyle(.blue)
                }
            }
        }
    }
    
    @ViewBuilder
    private func QuestionsSection() -> some View {
        Button {
            showQAModal = true
        } label: {
            VStack(alignment: .leading, spacing: 15) {
                Text("Pytania i odpowiedzi")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(mockQAItems.prefix(3))) { item in
                        Text("• \(item.question)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                if mockQAItems.count > 3 {
                    Button {
                        showQAModal = true
                    } label: {
                        HStack {
                            Text("Pokaż wszystkie \(mockQAItems.count) pytań")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.blue)
                        .padding(.top, 5)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
        
    @ViewBuilder
    private func MapSection(location: EventLocation) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Lokalizacja")
                .font(.headline)
            
            Map(position: $position) {
                Annotation(event.title, coordinate: location.coordinate) {
                    ZStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 14, height: 14)
                        
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 2)
                            .frame(width: 14, height: 14)
                    }
                    .shadow(radius: 3)
                }
            }
            .mapControls {
                MapCompass()
            }
            .frame(height: 300)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 4)
            
            Button {
                location.toMapItem(name: event.title).openInMaps()
            } label: {
                HStack(spacing: 5) {
                    Text("Znajdź trasę")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Image(systemName: "arrow.right")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .glassEffect(.regular.interactive(), in: .capsule)
            }
        }
    }
}



struct QuestionsModalView: View {
    @Environment(\.dismiss) private var dismiss
//    @StateObject private var viewModel = QAViewModel()
    @State private var showingQuestionSheet = false
    @State private var newQuestion = ""
    
    @FocusState private var focused: Bool
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(mockQAItems) { item in
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
            .sheet(isPresented: $showingQuestionSheet) {
                AskQuestionView(questionText: $newQuestion) {
                    if !newQuestion.isEmpty {
//                        viewModel.askQuestion(newQuestion)
                        newQuestion = ""
                        showingQuestionSheet = false
                    }
                }
            }
        }
    }
}

struct AskQuestionView: View {
    @Binding var questionText: String
    let onSubmit: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Zadaj pytanie")) {
                    TextEditor(text: $questionText)
                        .frame(minHeight: 150)
                }
            }
            .navigationTitle("Nowe pytanie")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Anuluj") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Wyślij") {
                        onSubmit()
                    }
                    .disabled(questionText.isEmpty)
                }
            }
        }
    }
}
#Preview {
    EventView(event: mockEvents[0])
}
