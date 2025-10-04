//
//  RegisterView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct RegisterView: View {
    @Binding var currentScreen: AuthenticationScreen
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isProcessing: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundGradient
            
            VStack(spacing: 0) {
                ScrollView {
                    AppLogo
                    
                    VStack(spacing: 20) {
                        LoginFields
                        OtherLoginProviders
                    }
                    .padding(.horizontal, 30)
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
                
                Footer
            }
        }
    }
    
    @ViewBuilder
    private var BackgroundGradient: some View {
        LinearGradient(
            colors: [.blue.opacity(0.1), .purple.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var AppLogo: some View {
        VStack(spacing: 20) {
            Image("logo-vertical")
                .resizable()
                .frame(width: 100, height: 100 * 737 / 433)
        }
        .padding(.top, 40)
        .padding(.bottom, 30)
    }
    
    @ViewBuilder
    private var LoginFields: some View {
        Group {
            TextField("Adres e-mail", text: $email)
                .textFieldStyle(.floatingLabel(systemImage: "envelope"))
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Hasło", text: $password)
                .textFieldStyle(.floatingLabel(systemImage: "lock"))
            
            Button {
                handleAuthentication()
            } label: {
                HStack (spacing: 8) {
                    Text("Kontynuuj")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Image(systemName: "arrow.right")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.gradient(isLoading: isProcessing))
            .disabled(isProcessing)
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    private var OtherLoginProviders: some View {
        VStack(spacing: 15) {
            Text("zarejestruj się z użyciem")
                .foregroundColor(.secondary)
                .font(.caption)
            
            HStack(spacing: 20) {
                ProviderButton(for: .Apple) {
                    
                }
                
                ProviderButton(for: .Google) {
                    
                }
                
                ProviderButton(for: .Facebook) {
                    
                }
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    private var Footer: some View {
        HStack(spacing: 4) {
            Text("Masz konto?")
                .foregroundColor(.secondary)
            
            Button("zaloguj się") {
                currentScreen = .Login
            }
            .foregroundColor(.blue)
            .fontWeight(.semibold)
        }
        .padding(.vertical, 20)
    }
    
    private func handleAuthentication() {
        isProcessing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isProcessing = false
        }
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        let hasCapitalLetter = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasSpecialMark = password.range(of: "[0-9!@#%^&*()_+={}:?.,]", options: .regularExpression) != nil
//        let isAllowed = password.range(of: "[\"';\\\\|<>$\\n\\r]", options: .regularExpression) == nil
        
        let isLongEnough = password.count >= 12

        return hasCapitalLetter && hasSpecialMark && isLongEnough // && isAllowed
    }
}
