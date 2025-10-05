//
//  LoginView.swift
//  Volunteers
//
//  Created by Arkadiusz Skupień on 04/10/2025.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    @Binding var currentScreen: AuthenticationScreen
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showsPassword: Bool = false
    @State private var isProcessing: Bool = false
    
    @State private var wrongPasswordTrigger: Bool = false
    
    enum LoginField {
        case email, password
    }
    
    @FocusState private var focusedField: LoginField?
    
    var body: some View {
        ZStack {
            BackgroundGradient
                .onTapGesture {
                    focusedField = nil
                }
            
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
                .focused($focusedField, equals: .email)
            
//            SecureField("Password", text: $password)
//                .textFieldStyle(.floatingLabel(systemImage: "lock"))
//                .focused($focusedField, equals: .password)
//                .shaking(on: wrongPasswordTrigger)
            
            VStack {
                if showsPassword {
                    TextField("Hasło", text: $password)
                } else {
                    SecureField("Hasło", text: $password)
                }
            }
            .textFieldStyle(.floatingLabel(systemImage: "lock", isSecure: true))
            .overlay(alignment: .trailing) {
                Button {
                    showsPassword.toggle()
                } label: {
                    Image(systemName: showsPassword ? "eye" : "eye.slash")
                        .font(.caption)
                        .padding(.trailing, 10)
                }
                .buttonStyle(.floatingSecureFieldStyle())
            }
            .focused($focusedField, equals: .password)
            .shaking(on: wrongPasswordTrigger)
            
            Button("Zaloguj się") {
//                wrongPasswordTrigger.toggle()
                
//                focusedField = .password
                
                handleAuthentication()
            }
            .font(.headline)
            .foregroundColor(.white)
            .buttonStyle(.gradient(isLoading: isProcessing))
            .disabled(isProcessing)
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    private var OtherLoginProviders: some View {
        VStack(spacing: 15) {
            Text("lub kontynuuj z użyciem")
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
            Text("Nie masz jeszcze konta?")
                .foregroundColor(.secondary)
            
            Button("zarejestruj się") {
                currentScreen = .Register
            }
            .foregroundColor(.blue)
            .fontWeight(.semibold)
        }
        .padding(.vertical, 20)
    }
    
    private func handleAuthentication() {
        isProcessing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isProcessing = false
            
            isLoggedIn = true
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
