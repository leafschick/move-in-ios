import SwiftUI

struct VendorBookingRequestsView: View {
    @State private var selectedFilter: RequestFilter = .all
    @State private var requests: [BookingRequest] = BookingRequest.sampleData

    var filteredRequests: [BookingRequest] {
        switch selectedFilter {
        case .all:
            return requests
        case .pending:
            return requests.filter { $0.status == .pending }
        case .approved:
            return requests.filter { $0.status == .approved }
        case .declined:
            return requests.filter { $0.status == .declined }
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerCard
                filterSection

                if filteredRequests.isEmpty {
                    emptyStateView
                } else {
                    requestsList
                }
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .navigationTitle("Booking Requests")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Booking Requests")
                .font(.title2)
                .fontWeight(.bold)

            Text("Review incoming customer requests and update their status.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var filterSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Filter")
                .font(.headline)

            HStack(spacing: 10) {
                ForEach(RequestFilter.allCases, id: \.self) { filter in
                    Button {
                        selectedFilter = filter
                    } label: {
                        Text(filter.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(selectedFilter == filter ? Color.blue : Color.white)
                            .foregroundColor(selectedFilter == filter ? .white : .primary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
    }

    private var requestsList: some View {
        VStack(spacing: 16) {
            ForEach(filteredRequests.indices, id: \.self) { index in
                let request = filteredRequests[index]

                if let realIndex = requests.firstIndex(where: { $0.id == request.id }) {
                    bookingRequestCard(for: realIndex)
                }
            }
        }
    }

    private func bookingRequestCard(for index: Int) -> some View {
        let request = requests[index]

        return VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(request.customerName)
                        .font(.headline)

                    Text(request.moveType)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                statusBadge(for: request.status)
            }

            Divider()

            detailRow(icon: "calendar", title: "Move Date", value: request.moveDate)
            detailRow(icon: "location", title: "From", value: request.pickupLocation)
            detailRow(icon: "mappin.and.ellipse", title: "To", value: request.dropoffLocation)
            detailRow(icon: "dollarsign.circle", title: "Estimated Price", value: request.price)
            detailRow(icon: "tray.full", title: "Items", value: request.items)

            if !request.notes.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Notes")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text(request.notes)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            if request.status == .pending {
                HStack(spacing: 12) {
                    Button {
                        requests[index].status = .approved
                    } label: {
                        Text("Approve")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    Button {
                        requests[index].status = .declined
                    } label: {
                        Text("Decline")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
    }

    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.subheadline)
            }

            Spacer()
        }
    }

    private func statusBadge(for status: BookingStatus) -> some View {
        Text(status.rawValue)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(statusColor(for: status).opacity(0.15))
            .foregroundColor(statusColor(for: status))
            .clipShape(Capsule())
    }

    private func statusColor(for status: BookingStatus) -> Color {
        switch status {
        case .pending:
            return .orange
        case .approved:
            return .green
        case .declined:
            return .red
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .font(.system(size: 40))
                .foregroundColor(.gray)

            Text("No requests found")
                .font(.headline)

            Text("There are no booking requests in this category right now.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

enum RequestFilter: String, CaseIterable {
    case all = "All"
    case pending = "Pending"
    case approved = "Approved"
    case declined = "Declined"
}

enum BookingStatus: String {
    case pending = "Pending"
    case approved = "Approved"
    case declined = "Declined"
}

struct BookingRequest: Identifiable {
    let id = UUID()
    let customerName: String
    let moveType: String
    let moveDate: String
    let pickupLocation: String
    let dropoffLocation: String
    let price: String
    let items: String
    let notes: String
    var status: BookingStatus

    static let sampleData: [BookingRequest] = [
        BookingRequest(
            customerName: "Sarah Johnson",
            moveType: "2 Bedroom Apartment",
            moveDate: "Apr 14, 2026",
            pickupLocation: "Downtown Toronto",
            dropoffLocation: "North York",
            price: "$320",
            items: "Furniture, boxes, mattress",
            notes: "Needs help with stairs and large sofa.",
            status: .pending
        ),
        BookingRequest(
            customerName: "Michael Chen",
            moveType: "Office Relocation",
            moveDate: "Apr 16, 2026",
            pickupLocation: "Mississauga",
            dropoffLocation: "Etobicoke",
            price: "$540",
            items: "Desks, chairs, office equipment",
            notes: "Morning move preferred.",
            status: .approved
        ),
        BookingRequest(
            customerName: "Emma Wilson",
            moveType: "Small Condo Move",
            moveDate: "Apr 18, 2026",
            pickupLocation: "Scarborough",
            dropoffLocation: "Downtown Toronto",
            price: "$250",
            items: "10 boxes, small table, TV",
            notes: "",
            status: .pending
        ),
        BookingRequest(
            customerName: "Daniel Brown",
            moveType: "1 Bedroom Apartment",
            moveDate: "Apr 20, 2026",
            pickupLocation: "Markham",
            dropoffLocation: "Richmond Hill",
            price: "$280",
            items: "Bed, dresser, boxes",
            notes: "Elevator available in both buildings.",
            status: .declined
        )
    ]
}

#Preview {
    NavigationStack {
        VendorBookingRequestsView()
    }
}
