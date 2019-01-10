//
//  AppDelegate.swift
//  Todoey
//
//  Created by Nicholas Gavin on 12/13/18.
//  Copyright © 2018 Nicholas Gavin. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing realm: \(error)")
        }
        
        return true
    }
}

