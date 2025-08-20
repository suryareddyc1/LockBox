//
//  ContentView.swift
//  LockBox
//
//  Created by Surya Vummadi on 21/06/25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(Strings.appTitle, systemImage: "lock")
                }

            SettingsView()
                .tabItem {
                    Label(Strings.settingsTitle, systemImage: "gear")
                }
        }
    }
}
