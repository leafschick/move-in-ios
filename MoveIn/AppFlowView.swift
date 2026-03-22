import SwiftUI

struct AppFlowView: View {
    enum Screen {
        case login
        case signup
        case home
    }

    @State private var currentScreen: Screen = .login

    var body: some View {
        NavigationStack {
            Group {
                switch currentScreen {
                case .login:
                    LoginView(
                        onLoginSuccess: {
                            currentScreen = .home
                        },
                        onShowSignUp: {
                            currentScreen = .signup
                        }
                    )

                case .signup:
                    SignUpView(
                        onBackToLogin: {
                            currentScreen = .login
                        },
                        onSignUpComplete: {
                            currentScreen = .login
                        }
                    )

                case .home:
                    HomePlaceholderView()
                }
            }
        }
    }
}
