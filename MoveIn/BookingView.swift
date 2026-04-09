//
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
    @State private var goToConfirmation = false

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
                        Text("Estimated Price: $180 - $350")
                        Text("Status: Pending Confirmation")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    Button(action: {
                        NotificationManager.shared.scheduleNotification(
                            title: "Booking Confirmed ✅",
                            message: "Your booking for moving assistance has been successfully confirmed!",
                            delay: 3.0,
                            type: .success
                        )

                        goToConfirmation = true
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
                            serviceName: "EasyMove Pro",
                            bookingDate: movingDate.isEmpty ? "Not provided" : movingDate,
                            bookingTime: preferredTime.isEmpty ? "Not provided" : preferredTime,
                            pickupLocation: fromLocation.isEmpty ? "Not provided" : fromLocation,
                            dropoffLocation: toLocation.isEmpty ? "Not provided" : toLocation,
                            totalPrice: "$180 - $350",
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
        }
    }
}

#Preview {
    BookingView()
}
