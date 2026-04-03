import SwiftUI

struct ContentView: View {
    @EnvironmentObject var notificationManager: NotificationManager

    var body: some View {
        AppFlowView()
            .onAppear {
                notificationManager.requestAuthorization()
            }
    }
}

#Preview {
    ContentView()
}
