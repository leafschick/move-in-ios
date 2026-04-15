//
//  ProfileView.swift
//  MoveIn
//
//  Created by Sofiia Beliak on 2026-03-26.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("currentUserEmail") private var currentUserEmail = "guest@movein.com"

    private var displayName: String {
        let emailPrefix = currentUserEmail.split(separator: "@").first.map(String.init) ?? "Customer"
        let cleaned = emailPrefix.replacingOccurrences(of: ".", with: " ")
        return cleaned
            .split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 30)

            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 90, height: 90)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                )

            Text(displayName)
                .font(.headline)
                .padding(.bottom, 30)

            VStack(spacing: 12) {
                profileCard(
                    title: "Email",
                    value: currentUserEmail,
                    systemImage: "envelope.fill"
                )

                profileCard(
                    title: "Phone Number",
                    value: "+1 (555) 123-4567",
                    systemImage: "phone.fill"
                )

                profileCard(
                    title: "Location",
                    value: "Los Angeles, CA",
                    systemImage: "mappin.and.ellipse"
                )

                profileCard(
                    title: "Account Type",
                    value: "Move-In Customer",
                    systemImage: "truck.box.fill"
                )
            }
            .padding(.horizontal)

            Spacer()
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
