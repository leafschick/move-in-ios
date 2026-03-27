//
//  ProfileView.swift
//  MoveIn
//
//  Created by Sofiia Beliak on 2026-03-26.
//
import SwiftUI

struct ProfileView: View {
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

            Text("John Carter")
                .font(.headline)

            Text("john.carter@email.com")
                .foregroundColor(.gray)

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "phone")
                    Text("+1 (555) 123-4567")
                }

                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Los Angeles, CA")
                }

                HStack {
                    Image(systemName: "truck.box")
                    Text("Move-In Customer")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)

            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
