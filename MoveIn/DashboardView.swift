//
//  DashboardView.swift
//  MoveIn
//
//  Created by Sofiia Beliak on 2026-03-26.
//

import SwiftUI

struct DashboardView: View {
    @AppStorage("selectedTab") private var selectedTabRaw = TabItem.home.rawValue
    @AppStorage("currentUserEmail") private var currentUserEmail = "guest@movein.com"

    @State private var hasBooking = false
    @State private var bookingServiceName = "EasyMove Pro"
    @State private var bookingDate = ""
    @State private var bookingTime = ""
    @State private var bookingPickup = ""
    @State private var bookingDropoff = ""
    @State private var bookingPrice = "$180 - $350"

    private var userBookingKeyPrefix: String {
        currentUserEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private var displayName: String {
        let emailPrefix = currentUserEmail.split(separator: "@").first.map(String.init) ?? "Customer"
        let cleaned = emailPrefix.replacingOccurrences(of: ".", with: " ")
        return cleaned
            .split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    private func loadBooking() {
        let defaults = UserDefaults.standard
        hasBooking = defaults.bool(forKey: "hasBooking_\(userBookingKeyPrefix)")
        bookingServiceName = defaults.string(forKey: "bookingServiceName_\(userBookingKeyPrefix)") ?? "EasyMove Pro"
        bookingDate = defaults.string(forKey: "bookingDate_\(userBookingKeyPrefix)") ?? ""
        bookingTime = defaults.string(forKey: "bookingTime_\(userBookingKeyPrefix)") ?? ""
        bookingPickup = defaults.string(forKey: "bookingPickup_\(userBookingKeyPrefix)") ?? ""
        bookingDropoff = defaults.string(forKey: "bookingDropoff_\(userBookingKeyPrefix)") ?? ""
        bookingPrice = defaults.string(forKey: "bookingPrice_\(userBookingKeyPrefix)") ?? "$180 - $350"
    }

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

                    Text(displayName)
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(currentUserEmail)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(16)
                .padding(.horizontal)

                HStack(spacing: 12) {
                    Text("Upcoming (\(hasBooking ? 1 : 0))")
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

                if hasBooking {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Upcoming Booking")
                            .font(.headline)

                        Text("Service: \(bookingServiceName)")
                        Text("Date: \(bookingDate)")
                        Text("Time: \(bookingTime)")
                        Text("Pickup: \(bookingPickup)")
                        Text("Drop-off: \(bookingDropoff)")
                        Text("Estimated Price: \(bookingPrice)")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    Button(action: {
                        selectedTabRaw = TabItem.search.rawValue
                    }) {
                        Text("Add Booking")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                } else {
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
                            selectedTabRaw = TabItem.search.rawValue
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
                }

                Spacer()
            }
            .padding(.top)
        }
        .onAppear {
            loadBooking()
        }
        .onChange(of: currentUserEmail) { _ in
            loadBooking()
        }
    }
}

#Preview {
    DashboardView()
}
