//
//  VendorLoginView.swift
//  MoveIn
//
//  Created by Ayesha Akbar on 2026-04-08.
//

import SwiftUI

struct VendorLoginView: View {
    let onLoginSuccess: () -> Void
    let onBack: () -> Void

    @State private var businessEmail = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Spacer()
                        .frame(height: 32)

                    headerSection

                    VStack(spacing: 20) {
                        AuthTextField(
                            title: "Business Email",
                            placeholder: "Enter your business email",
                            systemImage: "building.2",
                            text: $businessEmail
                        )

                        AuthTextField(
                            title: "Password",
                            placeholder: "Enter your password",
                            systemImage: "lock",
                            text: $password,
                            isSecure: true
                        )
                    }
                    .padding(.top, 8)

                    Button(action: {
                        onLoginSuccess()
                    }) {
                        Text("Login as Vendor")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(Color.blue)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 5)
                    }
                    .padding(.top, 4)

                    Spacer()
                        .frame(height: 30)
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

            Text("Vendor Login")
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

            Text("Login to manage jobs, requests, and vendor activity")
                .font(.system(size: 18))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 24)
    }
}

#Preview {
    VendorLoginView(
        onLoginSuccess: {},
        onBack: {}
    )
}
