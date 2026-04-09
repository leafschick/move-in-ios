import SwiftUI

struct LoginView: View {
    let onCustomerLogin: () -> Void
    let onVendorLogin: () -> Void
    let onShowSignUp: () -> Void
    

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
                            onCustomerLogin()
                        }) {
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                                    .frame(width: 50, height: 50)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Login as Customer")
                                        .font(.system(size: 18, weight: .semibold))

                                    Text("Book movers and manage your move")
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
                            onVendorLogin()
                        }) {
                            HStack(spacing: 16) {
                                Image(systemName: "building.2.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                                    .frame(width: 50, height: 50)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Login as Vendor")
                                        .font(.system(size: 18, weight: .semibold))

                                    Text("Manage jobs and customer requests")
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

            Text("Choose how you want to continue")
                .font(.system(size: 18))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 24)
    }
}

#Preview {
    LoginView(
        onCustomerLogin: {},
        onVendorLogin: {},
        onShowSignUp: {}
    )
}
