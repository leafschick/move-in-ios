//
//  MoveInApp.swift
//  MoveIn
//
//  Created by Ayesha Akbar on 2026-03-22.
//

import SwiftUI
import SwiftData
import UserNotifications
import Combine

@main
struct MoveInApp: App {
    @StateObject private var notificationManager = NotificationManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
        .modelContainer(for: [UserProfile.self, Mover.self, Booking.self])
    }
}

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    @Published var notifications: [AppNotification] = []
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        
        // Initial mock notifications to display when the app opens
        self.notifications = [
            AppNotification(title: "Welcome to MoveIn", message: "Find the best local movers today.", timeAgo: "Just now", isRead: false, type: .promo),
            AppNotification(title: "New Message", message: "Urban Move Co: 'Hi, we will be arriving exactly on time.'", timeAgo: "2h ago", isRead: true, type: .message)
        ]
    }
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else {
                print("Notification authorization success: \(success)")
            }
        }
    }
    
    func scheduleNotification(title: String, message: String, delay: TimeInterval, type: AppNotification.NotificationType) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default
        
        let identifier = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    // Delegate method to show notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let title = notification.request.content.title
        let message = notification.request.content.body
        
        // Simple heuristic to assign type
        var noteType: AppNotification.NotificationType = .message
        let lowerTitle = title.lowercased()
        if lowerTitle.contains("confirm") || lowerTitle.contains("success") {
            noteType = .success
        } else if lowerTitle.contains("alert") || lowerTitle.contains("required") {
            noteType = .alert
        } else if lowerTitle.contains("offer") || lowerTitle.contains("promo") {
            noteType = .promo
        }
        
        let newNotification = AppNotification(title: title, message: message, timeAgo: "Just now", isRead: false, type: noteType)
        
        DispatchQueue.main.async {
            self.notifications.insert(newNotification, at: 0)
        }
        
        // Show as banner and play sound even if app is foregrounded
        completionHandler([.banner, .sound])
    }
    
    func clearAll() {
        DispatchQueue.main.async {
            self.notifications.removeAll()
        }
    }
}
