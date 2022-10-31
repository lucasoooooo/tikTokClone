//
//  ContentView.swift
//  tikTokClone
//
//  Created by Lucas Balangero on 5/11/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
//    @EnvironmentObject var directory: Directory
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
    }
    
    var body: some View {
        TabView{
            PlayerView().tabItem{
                Label("", systemImage: "house")
            }
            
            UploadView().tabItem{
                Label("", systemImage: "plus")
            }
            
        }
    }
}

