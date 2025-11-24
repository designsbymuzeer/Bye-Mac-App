
//
//  Bye - Quit running apps easy!
//  Created by Abdul (designsbymuzeer)
//
//  Designed and Developed with ❤️.
//  Copyright © 2025 designsbymuzeer. All rights reserved.
//


import SwiftUI

@main
struct ByeApp: App {
    
    var body: some Scene {
        // 1. The Menu Bar Icon
        MenuBarExtra("Bye", systemImage: "hand.wave.fill") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
        
        // 2. The Settings Window
        Settings {
            SettingsView()
        }
    }
}
