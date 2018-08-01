//
//  AppDelegate.swift
//  todo
//
//  Created by 森川彩音 on 2018/06/10.
//  Copyright © 2018年 森川彩音. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                
                if granted {
                    print("通知許可")
                    
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self as? UNUserNotificationCenterDelegate
                    
                } else {
                    print("通知拒否")
                }
            })
            
        } else {
            // iOS 9以下
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        for i in Birthday.self {
            print(i.name)
            var name = i.name
            var month  = i.month
            var day = i.day
            notificationTime.month = i.month
            notificationTime.date = i.day
            trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
        }
        
        var notificationTime = DateComponents()
        var trigger: UNNotificationTrigger
        
        let realm = try! Realm()
        if realm.objects(Birthday.self) != nil{
            print("最初に\(realm.objects(Birthday.self)))")
        }
        
        
        // 12時に通知する場合
        notificationTime.hour = 14
        notificationTime.minute = 55
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        /*その他の設定*/
        
        // 設定したタイミングを起点として1分後に通知したい場合
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        
        let content = UNMutableNotificationContent()
        
        // 通知のメッセージセット
        content.title = ""
        content.body = "食事の時間になりました！"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        
        // 通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //　通知設定に必要なクラスをインスタンス化
//        let trigger: UNNotificationTrigger
//        let content = UNMutableNotificationContent()
//        var notificationTime = DateComponents()
//        
//        // トリガー設定
//        
//        notificationTime.hour = 14
//        notificationTime.minute = 50
//        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
//        
//        // 通知内容の設定
//        content.title = ""
//        content.body = "食事の時間になりました！"
//        content.sound = UNNotificationSound.default()
//        
//        // 通知スタイルを指定
//        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
//        // 通知をセット
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)


        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "todo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

