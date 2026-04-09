import SwiftUI

struct AppFlowView: View {
    enum Screen {
        case landing
        case login
        case signup
        case customerLogin
        case vendorLogin
        case home
    }

    @State private var currentScreen: Screen = .landing

    var body: some View {
        NavigationStack {
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
                        currentScreen = .home
                    },
                    onBack: {
                        currentScreen = .login
                    }
            )
                case .home:
                    MainTabView()
                }
            }
        }
    }
}

#Preview {
    AppFlowView()
        .environmentObject(NotificationManager())
}
