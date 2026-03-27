//
//  DashboardView.swift
//  MoveIn
//
//  Created by Sofiia Beliak on 2026-03-26.
//
import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                VStack(spacing: 10) {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 70, height: 70)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        )

                    Text("John Carter")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("john.carter@email.com")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(16)
                .padding(.horizontal)

                HStack(spacing: 12) {
                    Text("Upcoming (0)")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.15))
                        .cornerRadius(10)

                    Text("History (0)")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                VStack(spacing: 12) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.system(size: 45))
                        .foregroundColor(.gray)

                    Text("No bookings yet")
                        .font(.headline)

                    Text("Start by browsing available movers")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    Button(action: {
                    }) {
                        Text("Browse Movers")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()

                Spacer()
            }
            .padding(.top)
        }
    }
}

#Preview {
    DashboardView()
}

