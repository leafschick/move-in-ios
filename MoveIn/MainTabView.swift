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
                onBack: { selectedTab = .home }
            )
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(TabItem.search)

            DashboardView(selectedTab: $selectedTab)
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

#Preview {
    MainTabView()
}