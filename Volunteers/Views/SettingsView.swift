//
//  SettingsView 2.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 05/10/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("userDisplayName") private var displayName: String = "Użytkownik"
    @AppStorage("userDescription") private var userDescription: String = ""
    @AppStorage("isAdult") private var isAdult: Bool = true
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true
    @AppStorage("privacyMode") private var privacyMode: Bool = false
    @AppStorage("selectedLanguage") private var language: String = "pl"
    @AppStorage("selectedAppearance") private var appearance = 0
    
    @State private var isEditingDisplayName = false
    @State private var tempDisplayName = ""
    @State private var showingLogoutAlert = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        if isEditingDisplayName {
                            TextField("Nazwa wyświetlana", text: $tempDisplayName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onSubmit {
                                    zapiszNazwe()
                                }
                            
                            HStack {
                                Button("Zapisz") {
                                    zapiszNazwe()
                                }
                                .buttonStyle(.borderedProminent)
                                
                                Button("Anuluj") {
                                    anulujEdycjeNazwy()
                                }
                                .buttonStyle(.bordered)
                            }
                            .font(.caption)
                        } else {
                            Text(displayName)
                                .font(.headline)
                            
                            Text(userDescription.isEmpty ? "Brak opisu" : userDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    if !isEditingDisplayName {
                        Button("Edytuj") {
                            rozpocznijEdycjeNazwy()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                NavigationLink("Edytuj opis") {
                    DescriptionEditorView(description: $userDescription)
                }
                
                Toggle("Konto dorosłego", isOn: $isAdult)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
            } header: {
                Text("Profil")
            }
            
           Section {
                Toggle("Powiadomienia push", isOn: $notificationsEnabled)
                Toggle("Tryb prywatny", isOn: $privacyMode)
                
                NavigationLink("Wygląd") {
                    AppearanceSettingsView()
                }
                
                NavigationLink("Język") {
                    LanguageSettingsView()
                }
            } header: {
                Text("Preferencje")
            }
           
            Section {
                NavigationLink("Organizacje") {
                    OrganizationsView()
                }
                
                NavigationLink("Prywatność i bezpieczeństwo") {
                    PrivacySecurityView()
                }
                
                Button("Usuń konto") {
                   
                }
                .foregroundColor(.red)
            } header: {
                Text("Konto")
            }
            
           
            Section {
                Button("Eksportuj dane") {
                    
                }
                .foregroundColor(.blue)
                
                Button("Wyczyść pamięć podręczną") {
                   
                }
                .foregroundColor(.orange)
            } header: {
                Text("Zarządzanie danymi")
            }
            
           
            Section {
                Button("Wyloguj się") {
                    showingLogoutAlert = true
                }
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
        }
        .navigationTitle("Ustawienia")
        .alert("Wyloguj się", isPresented: $showingLogoutAlert) {
            Button("Anuluj", role: .cancel) { }
            Button("Wyloguj", role: .destructive) {
                isLoggedIn = false
            }
        } message: {
            Text("Czy na pewno chcesz się wylogować?")
        }
    }
    
    private func rozpocznijEdycjeNazwy() {
        tempDisplayName = displayName
        isEditingDisplayName = true
    }
    
    private func zapiszNazwe() {
        if !tempDisplayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            displayName = tempDisplayName.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        isEditingDisplayName = false
    }
    
    private func anulujEdycjeNazwy() {
        isEditingDisplayName = false
        tempDisplayName = displayName
    }
}

// Widoki pomocnicze
struct DescriptionEditorView: View {
    @Binding var description: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section {
                TextEditor(text: $description)
                    .frame(minHeight: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            } header: {
                Text("O mnie")
            } footer: {
                Text("Opisz siebie innym użytkownikom. \(description.count)/500 znaków")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Edytuj opis")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Gotowe") {
                    dismiss()
                }
            }
        }
        .onChange(of: description) { oldValue, newValue in
            if newValue.count > 500 {
                description = String(newValue.prefix(500))
            }
        }
    }
}

struct AppearanceSettingsView: View {
    @AppStorage("selectedAppearance") private var appearance = 0
    
    var body: some View {
        Form {
            Section {
                Picker("Wygląd", selection: $appearance) {
                    Text("Systemowy").tag(0)
                    Text("Jasny").tag(1)
                    Text("Ciemny").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
            } header: {
                Text("Motyw")
            } footer: {
                Text("Wybierz preferowany wygląd aplikacji")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Wygląd")
    }
}

struct LanguageSettingsView: View {
    @AppStorage("selectedLanguage") private var language = "pl"
    
    let languages = [
        "pl": "Polski",
        "en": "English", 
        "de": "Deutsch",
        "es": "Español",
        "fr": "Français"
    ]
    
    var body: some View {
        Form {
            Section {
                Picker("Język", selection: $language) {
                    ForEach(Array(languages.keys.sorted()), id: \.self) { key in
                        Text(languages[key] ?? "").tag(key)
                    }
                }
            } header: {
                Text("Wybierz język")
            } footer: {
                Text("Zmiana języka może wymagać restartu aplikacji")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Język")
    }
}

struct PrivacySecurityView: View {
    @AppStorage("twoFactorEnabled") private var twoFactorEnabled = false
    @AppStorage("dataSharing") private var dataSharing = true
    
    var body: some View {
        Form {
            Section {
                Toggle("Uwierzytelnianie dwuetapowe", isOn: $twoFactorEnabled)
                Toggle("Udostępnianie danych analitycznych", isOn: $dataSharing)
            } header: {
                Text("Bezpieczeństwo")
            } footer: {
                Text("Uwierzytelnianie dwuetapowe zwiększa bezpieczeństwo Twojego konta")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Section {
                NavigationLink("Zmień hasło") {
                    ChangePasswordView()
                }
                
                NavigationLink("Podłączone urządzenia") {
                    ConnectedDevicesView()
                }
            } header: {
                Text("Zarządzanie kontem")
            }
        }
        .navigationTitle("Prywatność i bezpieczeństwo")
    }
}

struct OrganizationsView: View {
    @State private var organizations: [Organization] = []
    
    var body: some View {
        Form {
            if organizations.isEmpty {
                Text("Nie jesteś członkiem żadnej organizacji")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ForEach(organizations) { organization in
                    HStack {
                        Image(systemName: "building.2")
                            .foregroundColor(.blue)
                        
                        Text("\(organization.name)")
                        
                        Spacer()
                    }
                }
            }
            
            Button("Dołącz do nowej organizacji") {

            }
            .foregroundColor(.blue)
        }
        .navigationTitle("Moje organizacje")
    }
}

struct ChangePasswordView: View {
    var body: some View {
        Text("Widok zmiany hasła")
            .navigationTitle("Zmień hasło")
    }
}

struct ConnectedDevicesView: View {
    var body: some View {
        Text("Widok podłączonych urządzeń")
            .navigationTitle("Podłączone urządzenia")
    }
}
