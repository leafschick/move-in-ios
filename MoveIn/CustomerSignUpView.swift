//
//  CustomerSignUpView.swift
//  MoveIn
//
//  Created by Ayesha Akbar on 2026-04-08.
//

import SwiftUI

struct CustomerSignUpView: View {
    let onSignUpComplete: () -> Void
    let onBack: () -> Void
    let onShowLogin: () -> Void

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Spacer().frame(height: 32)

                    headerSection

                    VStack(spacing: 20) {
                        AuthTextField(
                            title: "Full Name",
                            placeholder: "Enter your full name",
                            systemImage: "person",
                            text: $fullName
                        )

                        AuthTextField(
                            title: "Email",
                            placeholder: "Enter your email",
                            systemImage: "envelope",
                            text: $email
                        )

                        AuthTextField(
                            title: "Password",
                            placeholder: "Create your password",
                            systemImage: "lock",
                            text: $password,
                            isSecure: true
                        )
                    }
                    .padding(.top, 8)

                    Button(action: {
                        onSignUpComplete()
                    }) {
                        Text("Create Customer Account")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(Color.blue)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 5)
                    }
                    .padding(.top, 4)

                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .foregroundColor(.black.opacity(0.75))

                        Button(action: {
                            onShowLogin()
                        }) {
                            Text("Login")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                    }
                    .font(.system(size: 17))
                    .padding(.top, 10)

                    Spacer().frame(height: 30)
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
    }

    private var topBar: some View {
        HStack {
            Button(action: {
                onBack()
            }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
            }

            Text("Customer Sign Up")
                .font(.system(size: 24, weight: .semibold))

            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(height: 72)
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color.gray.opacity(0.12))
                .frame(height: 1),
            alignment: .bottom
        )
    }

    private var headerSection: some View {
        VStack(spacing: 10) {
            Text("Move-In")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.blue)

            Text("Create your customer account")
                .font(.system(size: 18))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 24)
    }
}

#Preview {
    CustomerSignUpView(
        onSignUpComplete: {},
        onBack: {},
        onShowLogin: {}
    )
}
