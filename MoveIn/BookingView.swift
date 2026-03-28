import SwiftUI

struct BookingView: View {
    let mover: HomeMover

    @Environment(\.dismiss) private var dismiss
    @State private var movingDate    = Date()
    @State private var preferredTime = ""
    @State private var fromLocation  = ""
    @State private var toLocation    = ""
    @State private var showConfirm   = false

    private let timeOptions = [
        "Morning (8am–12pm)",
        "Afternoon (12pm–5pm)",
        "Evening (5pm–9pm)"
    ]

    private var formIsValid: Bool {
        !fromLocation.trimmingCharacters(in: .whitespaces).isEmpty &&
        !toLocation.trimmingCharacters(in: .whitespaces).isEmpty &&
        !preferredTime.isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Mover summary card
                    VStack(alignment: .leading, spacing: 6) {
                        Text(mover.name)
                            .font(.headline)
                        Text(mover.city)
                            .foregroundColor(.gray)
                        Text(mover.priceRange)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                    // Moving Date
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Moving Date", systemImage: "calendar")
                            .font(.system(size: 16, weight: .medium))
                        DatePicker(
                            "",
                            selection: $movingDate,
                            in: Date()...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    }

                    // Preferred Time
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Preferred Time", systemImage: "clock")
                            .font(.system(size: 16, weight: .medium))
                        Picker("Select time", selection: $preferredTime) {
                            Text("Select time").tag("")
                            ForEach(timeOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 12)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }

                    // From Location
                    VStack(alignment: .leading, spacing: 8) {
                        Label("From Location", systemImage: "location")
                            .font(.system(size: 16, weight: .medium))
                        TextField("Enter pickup address", text: $fromLocation)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    // To Location
                    VStack(alignment: .leading, spacing: 8) {
                        Label("To Location", systemImage: "location.fill")
                            .font(.system(size: 16, weight: .medium))
                        TextField("Enter delivery address", text: $toLocation)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    // Booking Summary
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Booking Summary")
                            .font(.headline)
                        Divider()
                        summaryRow("Service Provider", value: mover.name)
                        summaryRow("Estimated Cost",   value: mover.priceRange)
                        summaryRow("Date",             value: movingDate.formatted(date: .abbreviated, time: .omitted))
                        summaryRow("Time",             value: preferredTime.isEmpty ? "Not selected" : preferredTime)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                    // Confirm Button
                    Button {
                        showConfirm = true
                    } label: {
                        Text("Confirm Booking")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(formIsValid ? Color.blue : Color.gray)
                            .cornerRadius(12)
                    }
                    .disabled(!formIsValid)
                    .alert("Booking Confirmed!", isPresented: $showConfirm) {
                        Button("OK") { dismiss() }
                    } message: {
                        Text("Your booking with \(mover.name) has been submitted successfully.")
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Book Service")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    private func summaryRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label).foregroundColor(.gray)
            Spacer()
            Text(value).fontWeight(.semibold)
        }
        .font(.system(size: 15))
    }
}

#Preview {
    BookingView(mover: allMovers[0])
}