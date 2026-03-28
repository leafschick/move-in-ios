import SwiftUI

struct AppFlowView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var showSignUp = false

    var body: some View {
        if isLoggedIn {
            MainTabView()
        } else {
            NavigationStack {
                Group {
                    if showSignUp {
                        SignUpView(
                            onBackToLogin: {
                                showSignUp = false
                            },
                            onSignUpComplete: {
                                showSignUp = false
                                isLoggedIn = true
                            }
                        )
                    } else {
                        LoginView(
                            onLoginSuccess: {
                                isLoggedIn = true
                            },
                            onShowSignUp: {
                                showSignUp = true
                            }
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    AppFlowView()
}
