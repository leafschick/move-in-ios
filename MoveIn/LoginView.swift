import SwiftUI

struct LoginView: View {
    let onLoginSuccess: () -> Void
    let onShowSignUp: () -> Void

    @State private var email = ""
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
                            title: "Email",
                            placeholder: "Enter your email",
                            systemImage: "envelope",
                            text: $email
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
                        Text("Login")
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
                        Text("Don't have an account?")
                            .foregroundColor(.black.opacity(0.75))

                        Button(action: {
                            onShowSignUp()
                        }) {
                            Text("Sign Up")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                    }
                    .font(.system(size: 17))
                    .padding(.top, 10)

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
            Image(systemName: "arrow.left")
                .font(.system(size: 20, weight: .medium))

            Text("Login")
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

            Text("Welcome back! Please login to continue")
                .font(.system(size: 18))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 24)
    }
}

#Preview {
    LoginView(
        onLoginSuccess: {},
        onShowSignUp: {}
    )
}
