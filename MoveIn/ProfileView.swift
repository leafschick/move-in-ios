//
//  ProfileView.swift
//  MoveIn
//
//  Created by Sofiia Beliak on 2026-03-26.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("currentUserEmail") private var currentUserEmail = "guest@movein.com"
    @AppStorage("currentUserPhone") private var currentUserPhone = "+1 (555) 123-4567"
    @AppStorage("currentUserLocation") private var currentUserLocation = "Los Angeles, CA"
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var showingEditProfile = false

    private var displayName: String {
        let emailPrefix = currentUserEmail.split(separator: "@").first.map(String.init) ?? "Customer"
        let cleaned = emailPrefix.replacingOccurrences(of: ".", with: " ")
        return cleaned
            .split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Circle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 90, height: 90)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                        )
                        .padding(.top, 20)

                    Text(displayName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    VStack(spacing: 12) {
                        profileCard(
                            title: "Email",
                            value: currentUserEmail,
                            systemImage: "envelope.fill"
                        )

                        profileCard(
                            title: "Phone Number",
                            value: currentUserPhone,
                            systemImage: "phone.fill"
                        )

                        profileCard(
                            title: "Location",
                            value: currentUserLocation,
                            systemImage: "mappin.and.ellipse"
                        )

                        profileCard(
                            title: "Account Type",
                            value: "Move-In Customer",
                            systemImage: "truck.box.fill"
                        )
                    }
                    .padding(.horizontal)

                    // SETTINGS SECTION
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Settings")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        VStack(spacing: 0) {
                            // Dark Mode Toggle
                            Toggle(isOn: $isDarkMode) {
                                HStack(spacing: 14) {
                                    Image(systemName: "moon.fill")
                                        .foregroundColor(.indigo)
                                        .font(.system(size: 20))
                                    Text("Dark Mode")
                                        .font(.system(size: 17))
                                }
                            }
                            .padding()
                            
                            Divider()
                            
                            // Saved Vendors link
                            NavigationLink(destination: SavedVendorsView()) {
                                HStack(spacing: 14) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 20))
                                    Text("Saved Vendors")
                                        .font(.system(size: 17))
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                            
                            Divider()

                            // Logout Button
                            Button(action: {
                                NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
                            }) {
                                HStack(spacing: 14) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .foregroundColor(.red)
                                        .font(.system(size: 20))
                                    Text("Logout")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 40)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        showingEditProfile = true
                    }
                }
            }
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
        }
    }
}

private func profileCard(title: String, value: String, systemImage: String) -> some View {
    HStack(spacing: 14) {
        Image(systemName: systemImage)
            .foregroundColor(.blue)
            .font(.system(size: 20))

        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray)

            Text(value)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.black)
        }

        Spacer()
    }
    .padding()
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
}

#Preview {
    ProfileView()
}
