
//  BookingView.swift
//  MoveIn
//
//  Created by Sofia Beliak on 2026-03-26.
//

import SwiftUI

struct BookingView: View {
    @State private var movingDate = ""
    @State private var preferredTime = ""
    @State private var fromLocation = ""
    @State private var toLocation = ""

    @State private var showError = false
    @State private var errorMessage = ""
    @State private var goToConfirmation = false

    let serviceName = "EasyMove Pro"
    let serviceLocation = "Los Angeles, CA"
    let estimatedPrice = "$180 - $350"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Book Service")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 8) {
                    Text(serviceName)
                        .font(.headline)

                    Text(serviceLocation)
                        .foregroundColor(.gray)

                    Text(estimatedPrice)
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
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Preferred Time")
                        .fontWeight(.medium)
                    TextField("Enter preferred time", text: $preferredTime)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("From Location")
                        .fontWeight(.medium)
                    TextField("Enter pickup address", text: $fromLocation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("To Location")
                        .fontWeight(.medium)
                    TextField("Enter delivery address", text: $toLocation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Booking Summary")
                        .font(.headline)

                    Text("Service: Moving Assistance")
                    Text("Estimated Price: \(estimatedPrice)")
                    Text("Status: Pending Confirmation")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                }

                Button(action: {
                    confirmBooking()
                }) {
                    Text("Confirm Booking")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }

                NavigationLink(
                    destination: BookingConfirmationView(
                        serviceName: serviceName,
                        bookingDate: movingDate,
                        bookingTime: preferredTime,
                        pickupLocation: fromLocation,
                        dropoffLocation: toLocation,
                        totalPrice: estimatedPrice,
                        onEditBooking: {
                            goToConfirmation = false
                        }
                    ),
                    isActive: $goToConfirmation
                ) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
        }
    }

    func confirmBooking() {
        let trimmedDate = movingDate.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTime = preferredTime.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedFrom = fromLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTo = toLocation.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedDate.isEmpty || trimmedTime.isEmpty || trimmedFrom.isEmpty || trimmedTo.isEmpty {
            errorMessage = "Please fill in all booking details."
            showError = true
            return
        }

        showError = false
        goToConfirmation = true

        NotificationManager.shared.scheduleNotification(
            title: "Booking Confirmed ✅",
            message: "Your booking for moving assistance has been successfully confirmed!",
            delay: 3.0,
            type: .success
        )
    }
}

#Preview {
    NavigationStack {
        BookingView()
    }
}
