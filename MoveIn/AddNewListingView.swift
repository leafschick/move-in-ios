import SwiftUI

struct AddNewListingView: View {
    @State private var listingTitle = ""
    @State private var listingDescription = ""
    @State private var price = ""
    @State private var location = ""
    @State private var selectedService = "Local Move"
    @State private var selectedTruckSize = "Medium"
    @State private var isAvailable = true

    @State private var errorMessage = ""
    @State private var showSavedMessage = false

    private let serviceOptions = [
        "Local Move",
        "Long-Distance Move",
        "Packing Service",
        "Office Relocation"
    ]

    private let truckSizes = [
        "Small",
        "Medium",
        "Large"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerCard
                listingInfoCard
                serviceDetailsCard
                availabilityCard
                saveButton

                if !errorMessage.isEmpty {
                    errorCard
                }

                if showSavedMessage {
                    savedListingCard
                }
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .navigationTitle("Add New Listing")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Create a New Listing")
                .font(.title2)
                .fontWeight(.bold)

            Text("Add a service listing so customers can view and book your moving service.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var listingInfoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Listing Information")
                .font(.headline)

            TextField("Listing Title", text: $listingTitle)
                .textFieldStyle(.roundedBorder)

            TextField("Description", text: $listingDescription, axis: .vertical)
                .lineLimit(3...5)
                .textFieldStyle(.roundedBorder)

            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)

            TextField("Location", text: $location)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var serviceDetailsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Service Details")
                .font(.headline)

            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Service Type")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text(selectedService)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }

                    Spacer()

                    Picker("", selection: $selectedService) {
                        ForEach(serviceOptions, id: \.self) { service in
                            Text(service).tag(service)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Divider()

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Truck Size")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text(selectedTruckSize)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }

                    Spacer()

                    Picker("", selection: $selectedTruckSize) {
                        ForEach(truckSizes, id: \.self) { size in
                            Text(size).tag(size)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var availabilityCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Available for Booking")
                    .font(.headline)

                Spacer()

                Toggle("", isOn: $isAvailable)
                    .labelsHidden()
            }

            Text(isAvailable ? "Customers can book this listing." : "This listing is currently unavailable.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private var saveButton: some View {
        Button {
            saveListing()
        } label: {
            Text("Save Listing")
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

    private var savedListingCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Listing Saved")
                .font(.headline)
                .foregroundColor(.green)

            Text("Title: \(listingTitle)")
            Text("Description: \(listingDescription)")
            Text("Price: $\(price)")
            Text("Location: \(location)")
            Text("Service: \(selectedService)")
            Text("Truck Size: \(selectedTruckSize)")
            Text("Status: \(isAvailable ? "Available" : "Unavailable")")
        }
        .font(.subheadline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private func saveListing() {
        errorMessage = ""
        showSavedMessage = false

        if listingTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter a listing title."
            return
        }

        if listingDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter a description."
            return
        }

        if price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter a price."
            return
        }

        if location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter a location."
            return
        }

        showSavedMessage = true
    }
}

#Preview {
    NavigationStack {
        AddNewListingView()
    }
}
