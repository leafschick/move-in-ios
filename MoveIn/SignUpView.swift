import SwiftUI

struct SignUpView: View {
    let onBackToLogin:    () -> Void
    let onSignUpComplete: () -> Void

    @State private var fullName     = ""
    @State private var email        = ""
    @State private var phoneNumber  = ""
    @State private var password     = ""
    @State private var showError    = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    Spacer().frame(height: 28)

                    headerSection

                    VStack(spacing: 18) {
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
                            title: "Phone Number",
                            placeholder: "Enter your phone number",
                            systemImage: "phone",
                            text: $phoneNumber
                        )
                        AuthTextField(
                            title: "Password",
                            placeholder: "Create a password",
                            systemImage: "lock",
                            text: $password,
                            isSecure: true
                        )
                    }
                    .padding(.top, 8)

                    if showError {
                        Text(errorMessage)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button {
                        handleSignUp()
                    } label: {
                        Text("Create Account")
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
                        Button {
                            onBackToLogin()
                        } label: {
                            Text("Login")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                    }
                    .font(.system(size: 17))
                    .padding(.top, 10)

                    Spacer().frame(height: 32)
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
    }

    private func handleSignUp() {
        showError = false
        guard !fullName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            showError = true
            return
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            showError = true
            return
        }
        onSignUpComplete()
    }

    private var topBar: some View {
        HStack {
            Button { onBackToLogin() } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
            }
            Text("Sign Up")
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
            Text("Create an account to get started")
                .font(.system(size: 18))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }
}

#Preview {
    SignUpView(onBackToLogin: {}, onSignUpComplete: {})
}