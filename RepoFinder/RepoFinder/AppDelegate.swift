//
//  AppDelegate.swift
//  RepoFinder 3.0
//
//  Created by Jacob Singer on 12/5/19.
//  Copyright © 2019 Jacob Singer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        UserDefaults.standard.string(forKey: "tweakQuery")
        UserDefaults.standard.bool(forKey: "moreRepos")
        UserDefaults.standard.string(forKey: "packagesURL")
        UserDefaults.standard.string(forKey: "packagesViewTitle")
        UserDefaults.standard.string(forKey: "currentRepo")
        
        if launchedBefore
        {
            print("Not first launch.")
            UserDefaults.standard.set("purefocus", forKey: "tweakQuery")
        }
        else
        {
            print("First launch")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set("cydia://url/https://cydia.saurik.com/api/share#?source=", forKey: "pmURL")
            UserDefaults.standard.set("purefocus", forKey: "tweakQuery")
            UserDefaults.standard.set(true, forKey: "moreRepos")
            
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

