//
//  tikTokClone.swift
//  tikTokClone
//
//  Created by Lucas Balangero on 5/11/22.
//

import SwiftUI
import Firebase
import UIKit
import FirebaseCore


@main
struct tikTokClone_testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


//@main
//struct tikTokCloneApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
