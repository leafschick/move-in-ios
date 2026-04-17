import SwiftUI

struct ContentView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        AppFlowView()
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                notificationManager.requestAuthorization()
            }
    }
}

#Preview {
    ContentView()
}
