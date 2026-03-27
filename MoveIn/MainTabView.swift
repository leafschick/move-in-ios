import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    @State private var globalSearchText: String = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(
                selectedTab: $selectedTab,
                globalSearchText: $globalSearchText
            )
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(TabItem.home)

            SearchView(
                initialSearchText: $globalSearchText,
                onBack: {
                    selectedTab = .home
                }
            )
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(TabItem.search)

            DashboardView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Bookings")
                }
                .tag(TabItem.bookings)

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(TabItem.profile)
        }
        .tint(.blue)
    }
}

enum TabItem {
    case home
    case search
    case bookings
    case profile
}

struct BookingsPlaceholderTabView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "calendar.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.blue)

                Text("Bookings Page")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Your booking screen can be added here later.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6))
            .navigationTitle("Bookings")
        }
    }
}

struct ProfilePlaceholderTabView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.blue)

                Text("Profile Page")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Your profile screen can be added here later.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6))
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    MainTabView()
}
