//
//  AppDelegate.swift
//  DemoApp
//
//  Created by David Morales on 06/02/20.
//  Copyright © 2020 David Morales. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Google Maps
        GMSServices.provideAPIKey("AIzaSyAZMkYbtSh7uqRXvatB0YSVjaF1lJS9UjY");
        
        // --
        return true;
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role);
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}


}

