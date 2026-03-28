import SwiftUI

struct DashboardView: View {
    @Binding var selectedTab: TabItem

    @State private var activeTab: DashboardTab = .upcoming

    enum DashboardTab {
        case upcoming, history
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
                    Text("John Carter")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("john.carter@email.com")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(16)
                .padding(.horizontal)

                HStack(spacing: 0) {
                    tabButton(title: "Upcoming (0)", tab: .upcoming)
                    tabButton(title: "History (0)",  tab: .history)
                }
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.horizontal)

                switch activeTab {
                case .upcoming:
                    emptyState(
                        icon: "calendar.badge.exclamationmark",
                        message: "No upcoming bookings",
                        subtitle: "Start by browsing available movers"
                    )
                case .history:
                    emptyState(
                        icon: "clock.arrow.circlepath",
                        message: "No past bookings",
                        subtitle: "Your completed bookings will appear here"
                    )
                }

                Spacer()
            }
            .padding(.top)
        }
    }

    private func tabButton(title: String, tab: DashboardTab) -> some View {
        Button {
            activeTab = tab
        } label: {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(activeTab == tab ? Color.white : Color.clear)
                .foregroundColor(activeTab == tab ? .blue : .gray)
                .cornerRadius(10)
                .padding(3)
        }
    }

    private func emptyState(icon: String, message: String, subtitle: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 45))
                .foregroundColor(.gray)
            Text(message).font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Button {
                selectedTab = .search
            } label: {
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
}

#Preview {
    DashboardView(selectedTab: .constant(.bookings))
}