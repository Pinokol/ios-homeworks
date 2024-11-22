//
//  AppDelegate.swift
//  Navigation
//
//  Created by Виталий Мишин on 13.07.2023.
//

import UIKit
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let service = LocalNotificationsService()
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        service.registeForLatestUpdatesIfPossible()
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "default_configuration".localized, sessionRole: connectingSceneSession.role)
        
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
            print("did_sign_out_user".localized)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.badge, .banner, .sound]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if response.notification.request.content.userInfo["key"] as? String == "value" {
            print ("key = value")
        }
        if response.actionIdentifier == LocalNotificationsService.actionID {
            print ("You pushed me!")
        }
    }
    
}
