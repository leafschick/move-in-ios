import SwiftUI
import UIKit

struct BookingConfirmationView: View {
    @Environment(\.dismiss) var dismiss

    let serviceName: String
    let bookingDate: String
    let bookingTime: String
    let pickupLocation: String
    let dropoffLocation: String
    let totalPrice: String

    var onEditBooking: (() -> Void)? = nil

    @State private var showShareSheet = false

    private var shareText: String {
        """
        Move-In Booking Confirmation

        Service: \(serviceName)
        Date: \(bookingDate)
        Time: \(bookingTime)
        Pickup: \(pickupLocation)
        Drop-off: \(dropoffLocation)
        Total: \(totalPrice)

        Support: support@movein.com | (123) 456-7890
        """
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Confirmation")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Rental Details")
                        .font(.headline)
                        .fontWeight(.bold)

                    Text("Service: \(serviceName)")
                    Text("Date: \(bookingDate)")
                    Text("Time: \(bookingTime)")
                    Text("Pickup: \(pickupLocation)")
                    Text("Drop-off: \(dropoffLocation)")
                    Text("Total Cost: \(totalPrice)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Pickup Instructions")
                        .font(.headline)
                        .fontWeight(.bold)

                    Text("Please arrive on time and have your booking confirmation ready. Our team will assist you with the next steps.")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Support Contact")
                        .font(.headline)
                        .fontWeight(.bold)

                    Text("Email: support@movein.com")
                    Text("Phone: (123) 456-7890")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                HStack(spacing: 12) {
                    Button(action: {
                        showShareSheet = true
                    }) {
                        Text("Share Booking")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }

                    Button(action: {
                        onEditBooking?()
                        dismiss()
                    }) {
                        Text("Done")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                }

                Spacer(minLength: 20)
            }
            .padding()
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityViewController(activityItems: [shareText])
        }
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}

#Preview {
    NavigationStack {
        BookingConfirmationView(
            serviceName: "EasyMove Pro",
            bookingDate: "April 12, 2026",
            bookingTime: "10:00 AM",
            pickupLocation: "Toronto",
            dropoffLocation: "Mississauga",
            totalPrice: "$180 - $350",
            onEditBooking: { }
        )
    }
}
