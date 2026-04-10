import SwiftUI

struct VendorAvailabilityView: View {
    @State private var isAcceptingBookings = true

    @State private var selectedDays: Set<String> = ["Monday", "Tuesday", "Wednesday"]
    private let weekDays = [
        "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday", "Sunday"
    ]

    @State private var startTime = Calendar.current.date(from: DateComponents(hour: 9, minute: 0)) ?? Date()
    @State private var endTime = Calendar.current.date(from: DateComponents(hour: 17, minute: 0)) ?? Date()

    @State private var localMovesEnabled = true
    @State private var longDistanceEnabled = false
    @State private var packingHelpEnabled = false

    @State private var blackoutDate = Date()
    @State private var blackoutDates: [Date] = []

    @State private var notes = ""

    @State private var showSavedMessage = false
    @State private var errorMessage = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerCard
                bookingStatusCard
                availableDaysCard
                hoursCard
                servicesCard
                blackoutDatesCard
                notesCard
                saveButton

                if !errorMessage.isEmpty {
                    errorCard
                }

                if showSavedMessage {
                    savedSummaryCard
                }
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .navigationTitle("Availability")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Manage Availability")
                .font(.title2)
                .fontWeight(.bold)

            Text("Choose when you are available to accept bookings and what services you currently offer.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var bookingStatusCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Accepting Bookings")
                    .font(.headline)

                Spacer()

                Toggle("", isOn: $isAcceptingBookings)
                    .labelsHidden()
            }

            Text(isAcceptingBookings
                 ? "Customers can send you new booking requests."
                 : "Your profile is temporarily unavailable for new bookings.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var availableDaysCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Available Days")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(weekDays, id: \.self) { day in
                    Button {
                        toggleDay(day)
                    } label: {
                        HStack {
                            Text(day)
                                .font(.subheadline)
                                .fontWeight(.medium)

                            Spacer()

                            Image(systemName: selectedDays.contains(day) ? "checkmark.circle.fill" : "circle")
                        }
                        .foregroundColor(selectedDays.contains(day) ? .blue : .primary)
                        .padding()
                        .background(selectedDays.contains(day) ? Color.blue.opacity(0.08) : Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var hoursCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Working Hours")
                .font(.headline)

            DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
            DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var servicesCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Services Available")
                .font(.headline)

            Toggle("Local Moves", isOn: $localMovesEnabled)
            Toggle("Long-Distance Moves", isOn: $longDistanceEnabled)
            Toggle("Packing Help", isOn: $packingHelpEnabled)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var blackoutDatesCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Unavailable Dates")
                .font(.headline)

            DatePicker("Select Date", selection: $blackoutDate, displayedComponents: .date)

            Button {
                addSelectedBlackoutDate()
            } label: {
                Text("Add Unavailable Date")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.12))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            if blackoutDates.isEmpty {
                Text("No unavailable dates added.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                ForEach(blackoutDates, id: \.self) { date in
                    HStack {
                        Text(formattedDate(date))
                            .font(.subheadline)

                        Spacer()

                        Button(role: .destructive) {
                            blackoutDates.removeAll { Calendar.current.isDate($0, inSameDayAs: date) }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var notesCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notes")
                .font(.headline)

            TextField("Add schedule notes for customers", text: $notes, axis: .vertical)
                .lineLimit(4...6)
                .padding(12)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var saveButton: some View {
        Button {
            saveAvailability()
        } label: {
            Text("Save Availability")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }

    private var errorCard: some View {
        Text(errorMessage)
            .font(.subheadline)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var savedSummaryCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Availability Saved")
                .font(.headline)
                .foregroundColor(.green)

            Text("Status: \(isAcceptingBookings ? "Accepting bookings" : "Unavailable")")
            Text("Days: \(selectedDays.sorted().joined(separator: ", "))")
            Text("Hours: \(formattedTime(startTime)) - \(formattedTime(endTime))")
            Text("Services: \(selectedServicesText())")

            if !blackoutDates.isEmpty {
                Text("Unavailable Dates: \(blackoutDates.map { formattedDate($0) }.joined(separator: ", "))")
            }

            if !notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("Notes: \(notes)")
            }
        }
        .font(.subheadline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private func toggleDay(_ day: String) {
        if selectedDays.contains(day) {
            selectedDays.remove(day)
        } else {
            selectedDays.insert(day)
        }
    }

    private func addSelectedBlackoutDate() {
        let normalizedDate = Calendar.current.startOfDay(for: blackoutDate)
        let alreadyExists = blackoutDates.contains { Calendar.current.isDate($0, inSameDayAs: normalizedDate) }

        if !alreadyExists {
            blackoutDates.append(normalizedDate)
            blackoutDates.sort()
        }
    }

    private func saveAvailability() {
        errorMessage = ""
        showSavedMessage = false

        if selectedDays.isEmpty {
            errorMessage = "Please select at least one available day."
            return
        }

        if startTime >= endTime {
            errorMessage = "End time must be later than start time."
            return
        }

        if !localMovesEnabled && !longDistanceEnabled && !packingHelpEnabled {
            errorMessage = "Please enable at least one service."
            return
        }

        showSavedMessage = true
    }

    private func selectedServicesText() -> String {
        var services: [String] = []

        if localMovesEnabled { services.append("Local Moves") }
        if longDistanceEnabled { services.append("Long-Distance Moves") }
        if packingHelpEnabled { services.append("Packing Help") }

        return services.joined(separator: ", ")
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack {
        VendorAvailabilityView()
    }
}
