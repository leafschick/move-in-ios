//
//  LandingView.swift
//  MoveIn
//
//  Created by Ayesha Akbar on 2026-04-09.
//

import SwiftUI

struct LandingView: View {
    let onLoginTap: () -> Void
    let onSignUpTap: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.95), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 16) {
                    Image("movein_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                        .clipShape(RoundedRectangle(cornerRadius: 24))

                    Text("Move In")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.blue)

                    Text("Welcome to Move In")
                        .font(.system(size: 28, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    Text("This is a service for vendors and customers to communicate with each other to rent equipment and services.")
                        .font(.system(size: 17))
                        .foregroundColor(.black.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 28)
                }

                Spacer()

                VStack(spacing: 14) {
                    Button(action: onSignUpTap) {
                        Text("Sign Up")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }

                    Button(action: onLoginTap) {
                        Text("Login")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue, lineWidth: 1.5)
                            )
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    LandingView(
        onLoginTap: {},
        onSignUpTap: {}
    )
}
