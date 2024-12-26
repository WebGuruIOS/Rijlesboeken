//
//  AppDelegate.swift
//  Rijlesboeken
//
//  Created by Prince on 21/04/22.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase
//import FirebaseMessaging
import Messages

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
         FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
     
            UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
      
        
        if let userId = UserDefaults.standard.value(forKey: "user_id"){
            print(userId)
        }else{
            print("No User iD")
        }
        
        // Override point for customization after application launch.
        return true
    }
   
     
     func application(_ application: UIApplication,
                      didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                      fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                        -> Void) {
       // Print message ID.
       if let messageID = userInfo[gcmMessageIDKey] {
         print("Message ID: \(messageID)")
       }

       // Print full message.
       print(userInfo)

       completionHandler(UIBackgroundFetchResult.newData)
     }
     
     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
         if let messageID = userInfo[gcmMessageIDKey] {
           print("Message ID: \(messageID)")
         }
     }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Rijilesboeken")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
//CHANGE code
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                  -> Void) {
      let userInfo = notification.request.content.userInfo
      // Print full message.
      print(userInfo)

      // Change this to your preferred presentation option
      completionHandler([[.alert, .sound, .badge]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo
      // Print full message.
      print(userInfo)

      completionHandler()
    }
   
}
extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
      let dataDict: [String: String] = ["token": fcmToken ?? ""]
        UserDefaults.standard.set(dataDict["token"]!, forKey: "fcmToken")
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
   }
}

