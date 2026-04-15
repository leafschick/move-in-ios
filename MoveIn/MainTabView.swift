import SwiftUI

struct MainTabView: View {
    @AppStorage("selectedTab") private var selectedTabRaw = TabItem.home.rawValue
    @State private var globalSearchText: String = ""

    private var selectedTabBinding: Binding<TabItem> {
        Binding(
            get: { TabItem(rawValue: selectedTabRaw) ?? .home },
            set: { selectedTabRaw = $0.rawValue }
        )
    }

    var body: some View {
        TabView(selection: selectedTabBinding) {
            HomeView(
                selectedTab: selectedTabBinding,
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
                    selectedTabRaw = TabItem.home.rawValue
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

            NotificationView()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notifications")
                }
                .tag(TabItem.notifications)

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

enum TabItem: String {
    case home
    case search
    case bookings
    case notifications
    case profile
}

#Preview {
    MainTabView()
}
