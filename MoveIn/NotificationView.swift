import SwiftUI

struct AppNotification: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let timeAgo: String
    let isRead: Bool
    let type: NotificationType
    
    enum NotificationType {
        case success
        case alert
        case message
        case promo
        
        var iconName: String {
            switch self {
            case .success: return "checkmark.circle.fill"
            case .alert: return "exclamationmark.triangle.fill"
            case .message: return "envelope.fill"
            case .promo: return "star.circle.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .success: return .green
            case .alert: return .orange
            case .message: return .blue
            case .promo: return .purple
            }
        }
    }
}

struct NotificationView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                if notificationManager.notifications.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(notificationManager.notifications) { notification in
                                NotificationRowView(notification: notification)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationTitle("Notifications")
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "bell.slash.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("No Notifications")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("When you get notifications from movers or the system, they'll show up here.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

struct NotificationRowView: View {
    let notification: AppNotification
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            // Icon
            ZStack {
                Circle()
                    .fill(notification.type.color.opacity(0.15))
                    .frame(width: 48, height: 48)
                
                Image(systemName: notification.type.iconName)
                    .font(.system(size: 20))
                    .foregroundColor(notification.type.color)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Text(notification.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(notification.timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Text(notification.message)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            // Unread Indicator
            if !notification.isRead {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    NotificationView()
        .environmentObject(NotificationManager.shared)
}
