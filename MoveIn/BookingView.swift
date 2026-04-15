//
//  BookingView.swift
//  MoveIn
//
//  Created by Sofia Beliak on 2026-04-15.
//

import SwiftUI

struct BookingView: View {
    @State private var movingDate = ""
    @State private var preferredTime = ""
    @State private var fromLocation = ""
    @State private var toLocation = ""
    @State private var goToConfirmation = false
    @State private var showValidationAlert = false

    @AppStorage("currentUserEmail") private var currentUserEmail = "guest@movein.com"

    private var userBookingKeyPrefix: String {
        currentUserEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private func saveBooking() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "hasBooking_\(userBookingKeyPrefix)")
        defaults.set("EasyMove Pro", forKey: "bookingServiceName_\(userBookingKeyPrefix)")
        defaults.set(movingDate, forKey: "bookingDate_\(userBookingKeyPrefix)")
        defaults.set(preferredTime, forKey: "bookingTime_\(userBookingKeyPrefix)")
        defaults.set(fromLocation, forKey: "bookingPickup_\(userBookingKeyPrefix)")
        defaults.set(toLocation, forKey: "bookingDropoff_\(userBookingKeyPrefix)")
        defaults.set("$180 - $350", forKey: "bookingPrice_\(userBookingKeyPrefix)")
    }

    private var savedServiceName: String {
        UserDefaults.standard.string(forKey: "bookingServiceName_\(userBookingKeyPrefix)") ?? "EasyMove Pro"
    }

    private var savedBookingDate: String {
        UserDefaults.standard.string(forKey: "bookingDate_\(userBookingKeyPrefix)") ?? ""
    }

    private var savedBookingTime: String {
        UserDefaults.standard.string(forKey: "bookingTime_\(userBookingKeyPrefix)") ?? ""
    }

    private var savedBookingPickup: String {
        UserDefaults.standard.string(forKey: "bookingPickup_\(userBookingKeyPrefix)") ?? ""
    }

    private var savedBookingDropoff: String {
        UserDefaults.standard.string(forKey: "bookingDropoff_\(userBookingKeyPrefix)") ?? ""
    }

    private var savedBookingPrice: String {
        UserDefaults.standard.string(forKey: "bookingPrice_\(userBookingKeyPrefix)") ?? "$180 - $350"
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Book Service")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("EasyMove Pro")
                            .font(.headline)

                        Text("Los Angeles, CA")
                            .foregroundColor(.gray)

                        Text("$180 - $350")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    Group {
                        Text("Moving Date")
                            .fontWeight(.medium)
                        TextField("Enter moving date", text: $movingDate)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)

                        Text("Preferred Time")
                            .fontWeight(.medium)
                        TextField("Enter preferred time", text: $preferredTime)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)

                        Text("From Location")
                            .fontWeight(.medium)
                        TextField("Enter pickup address", text: $fromLocation)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)

                        Text("To Location")
                            .fontWeight(.medium)
                        TextField("Enter delivery address", text: $toLocation)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Booking Summary")
                            .font(.headline)

                        Text("Service: Moving Assistance")
                        Text("Estimated Price: $180 - $350")
                        Text("Status: Pending Confirmation")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    Button(action: {
                        if movingDate.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                            preferredTime.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                            fromLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                            toLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {

                            showValidationAlert = true
                        } else {
                            saveBooking()

                            NotificationManager.shared.scheduleNotification(
                                title: "Booking Confirmed ✅",
                                message: "Your booking for moving assistance has been successfully confirmed!",
                                delay: 3.0,
                                type: .success
                            )

                            goToConfirmation = true
                        }
                    }) {
                        Text("Confirm Booking")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .alert("Missing Information", isPresented: $showValidationAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Please fill in all booking details before confirming.")
                    }

                    NavigationLink(
                        destination: BookingConfirmationView(
                            serviceName: savedServiceName,
                            bookingDate: savedBookingDate,
                            bookingTime: savedBookingTime,
                            pickupLocation: savedBookingPickup,
                            dropoffLocation: savedBookingDropoff,
                            totalPrice: savedBookingPrice,
                            onEditBooking: { }
                        ),
                        isActive: $goToConfirmation
                    ) {
                        EmptyView()
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BookingView()
}
