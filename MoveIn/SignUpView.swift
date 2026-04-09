import SwiftUI

struct SignUpView: View {
    let onBack: () -> Void
    let onShowLogin: () -> Void

    @State private var showCustomerSignUp = false
    @State private var showVendorSignUp = false

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Spacer()
                        .frame(height: 32)

                    headerSection

                    VStack(spacing: 18) {
                        Button(action: {
                            showCustomerSignUp = true
                        }) {
                            HStack(spacing: 16) {
                                Image(systemName: "person.badge.plus.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                                    .frame(width: 50, height: 50)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Sign Up as Customer")
                                        .font(.system(size: 18, weight: .semibold))

                                    Text("Create an account to book movers and manage your move")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
                        }

                        Button(action: {
                            showVendorSignUp = true
                        }) {
                            HStack(spacing: 16) {
                                Image(systemName: "building.2.crop.circle.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                                    .frame(width: 50, height: 50)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Sign Up as Vendor")
                                        .font(.system(size: 18, weight: .semibold))

                                    Text("Register your moving business and manage customer requests")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
                        }
                    }
                    .padding(.top, 8)

                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .foregroundColor(.black.opacity(0.75))

                        Button(action: {
                            onShowLogin()
                        }) {
                            Text("Login")
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
        .fullScreenCover(isPresented: $showCustomerSignUp) {
            CustomerSignUpView(
                onSignUpComplete: {
                    showCustomerSignUp = false
                    onBack()
                },
                onBack: {
                    showCustomerSignUp = false
                },
                onShowLogin: {
                    showCustomerSignUp = false
                    onShowLogin()
                }
            )
        }
        .fullScreenCover(isPresented: $showVendorSignUp) {
            VendorSignUpView(
                onSignUpComplete: {
                    showVendorSignUp = false
                    onBack()
                },
                onBack: {
                    showVendorSignUp = false
                },
                onShowLogin: {
                    showVendorSignUp = false
                    onShowLogin()
                }
            )
        }
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

            Text("Choose how you want to create your account")
                .font(.system(size: 18))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 24)
    }
}

#Preview {
    SignUpView(
        onBack: {},
        onShowLogin: {}
    )
}
