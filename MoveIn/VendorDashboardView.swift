import SwiftUI

struct VendorDashboardView: View {
    let onLogout: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    headerCard

                    statCards

                    actionSection

                    requestsSection
                }
                .padding()
            }
            .background(Color(.systemGray6))
            .navigationTitle("Vendor Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Logout") {
                        onLogout()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome Back")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Vendor Portal")
                .font(.title2)
                .fontWeight(.bold)

            Text("Manage bookings, customer requests, and business activity.")
                .font(.system(size: 15))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
    }

    private var statCards: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                dashboardCard(
                    title: "Pending Requests",
                    value: "8",
                    systemImage: "clock.badge"
                )

                dashboardCard(
                    title: "Confirmed Jobs",
                    value: "12",
                    systemImage: "checkmark.circle"
                )
            }

            HStack(spacing: 12) {
                dashboardCard(
                    title: "Messages",
                    value: "5",
                    systemImage: "message"
                )

                dashboardCard(
                    title: "Rating",
                    value: "4.8",
                    systemImage: "star.fill"
                )
            }
        }
    }

    private var actionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)

            VStack(spacing: 12) {
                NavigationLink(destination: VendorBookingRequestsView()) {
                    actionRow(title: "View Booking Requests", systemImage: "doc.text")
                }
                .buttonStyle(.plain)

                NavigationLink(destination: VendorAvailabilityView()) {
                    actionRow(title: "Manage Availability", systemImage: "calendar")
                }
                .buttonStyle(.plain)

                NavigationLink(destination: AddNewListingView()) {
                    actionRow(title: "Add New Listing", systemImage: "plus.rectangle.on.rectangle")
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var requestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Requests")
                .font(.headline)

            requestRow(name: "Sarah Johnson", move: "2 Bedroom Apartment", date: "Apr 14, 2026")
            requestRow(name: "Michael Chen", move: "Office Relocation", date: "Apr 16, 2026")
            requestRow(name: "Emma Wilson", move: "Small Condo Move", date: "Apr 18, 2026")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func dashboardCard(title: String, value: String, systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: systemImage)
                .font(.system(size: 22))
                .foregroundColor(.blue)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
    }

    private func actionRow(title: String, systemImage: String) -> some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.blue)

            Text(title)
                .foregroundColor(.black)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }

    private func requestRow(name: String, move: String, date: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(name)
                .font(.system(size: 16, weight: .semibold))

            Text(move)
                .font(.system(size: 14))
                .foregroundColor(.secondary)

            Text(date)
                .font(.system(size: 13))
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    VendorDashboardView(onLogout: {})
}
