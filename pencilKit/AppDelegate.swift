//
//  AppDelegate.swift
//  pencilKit
//
//  Created by user on 12/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    static let Shared = AppDelegate()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func showAlert(title:String, message:String,view:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let subView = alert.view.subviews.first!
        let alertContentView = subView.subviews.first!
        alertContentView.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        alertContentView.layer.cornerRadius = 20
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        view.present(alert, animated: true, completion: nil)
    }
    
}

