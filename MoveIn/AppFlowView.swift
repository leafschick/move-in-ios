import SwiftUI

struct AppFlowView: View {
    enum Screen {
        case login
        case signup
        case home
    }

    @State private var currentScreen: Screen = .home

    var body: some View {
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
                MainTabView()
            }
        }
    }
}
