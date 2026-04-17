import SwiftUI

struct AppFlowView: View {
    enum Screen {
        case landing
        case login
        case signup
        case customerLogin
        case vendorLogin
        case home
        case vendorDashboard
    }

    @State private var currentScreen: Screen = .landing

    var body: some View {
        Group {
            switch currentScreen {
            case .landing:
                LandingView(
                    onLoginTap: {
                        currentScreen = .login
                    },
                    onSignUpTap: {
                        currentScreen = .signup
                    }
                )

            case .login:
                LoginView(
                    onCustomerLogin: {
                        currentScreen = .customerLogin
                    },
                    onVendorLogin: {
                        currentScreen = .vendorLogin
                    },
                    onShowSignUp: {
                        currentScreen = .signup
                    },
                    onBack: {
                        currentScreen = .landing
                    }
                )

            case .signup:
                SignUpView(
                    onBack: {
                        currentScreen = .landing
                    },
                    onShowLogin: {
                        currentScreen = .login
                    }
                )

            case .customerLogin:
                CustomerLoginView(
                    onLoginSuccess: {
                        currentScreen = .home
                    },
                    onBack: {
                        currentScreen = .login
                    },
                    onShowSignUp: {
                        currentScreen = .signup
                    }
                )

            case .vendorLogin:
                VendorLoginView(
                    onLoginSuccess: {
                        currentScreen = .vendorDashboard
                    },
                    onBack: {
                        currentScreen = .login
                    }
                )

            case .home:
                MainTabView()

            case .vendorDashboard:
                VendorDashboardView(
                    onLogout: {
                        currentScreen = .landing
                    }
                )
            }
        }
        // ✅ THIS IS THE FIX (listen for logout from HomeView)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("logout"))) { _ in
            currentScreen = .landing
        }
    }
}

#Preview {
    AppFlowView()
        .environmentObject(NotificationManager())
}
