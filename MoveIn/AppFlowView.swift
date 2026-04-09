import SwiftUI

struct AppFlowView: View {
    enum Screen {
        case login
        case signup
        case customerLogin
        case vendorLogin
        case home
    }

    @State private var currentScreen: Screen = .home

    var body: some View {
        NavigationStack {
            Group {
                switch currentScreen {
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
                        }
                    )
                    
                case .signup:
                    SignUpView(
                        onBackToLogin: {
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
}
