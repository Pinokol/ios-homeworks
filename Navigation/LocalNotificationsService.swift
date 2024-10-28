//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Виталий Мишин on 25.10.2024.
//

import Foundation
import UserNotifications

class LocalNotificationsService {//: NSObject, UNUserNotificationCenterDelegate {
    
    init(){
        setCategory()
    }
    
    func registeForLatestUpdatesIfPossible() {
        
        Task {
            
            do {
                let result = try await UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound])
                print("Notification accessed: \(result)")
                
                let status = await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
                
                if status == .authorized {
                    let content = UNMutableNotificationContent()
                    content.title = "Посмотрите последние обновления"
                    content.sound = .default
                    content.badge = 1
                    content.userInfo = ["key":"value"]
                    content.categoryIdentifier = categoryID
                    
                    let components = DateComponents(hour: 19, minute: 00)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                    
                    
                    let request = UNNotificationRequest(identifier: "Update", content: content, trigger: trigger)
                    
                    try await UNUserNotificationCenter.current().add(request)
                    
                    print("Request added")
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private var categoryID = "myCategory"
    static var actionID = "myAction"
    
    func setCategory() {
        
        let action = UNNotificationAction(identifier: Self.actionID, title: "Push me")
        
        let category = UNNotificationCategory(identifier: categoryID, actions: [action], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    //
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
    //
    //    }
}
