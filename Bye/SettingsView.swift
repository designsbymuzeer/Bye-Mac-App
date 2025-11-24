//
//  Bye - Quit running apps easy!
//  Created by Abdul (designsbymuzeer)
//
//  Designed and Developed with ❤️.
//  Copyright © 2025 designsbymuzeer. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
            
            AboutSettingsView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .frame(width: 450) // Auto-height for content, fixed width
    }
}

// --- TAB 1: GENERAL ---
struct GeneralSettingsView: View {
    @StateObject private var launchHelper = LaunchHelper.shared
    
    var body: some View {
        Form {
            Section {
                Toggle("Start Bye when I log in", isOn: $launchHelper.isLaunchAtLoginEnabled)
                    .toggleStyle(.checkbox)
                    .onChange(of: launchHelper.isLaunchAtLoginEnabled) { oldValue, newValue in
                        launchHelper.setLaunchAtLogin(enabled: newValue)
                    }
                
                Text("Show Bye in the menu bar automatically when your computer starts.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Section {
                Button(role: .destructive) {
                    NSApplication.shared.terminate(nil)
                } label: {
                    Text("Quit the Bye App Immediately")
                }
            }
        }
        .formStyle(.grouped)
        .padding()
        .frame(height: 190)
    }
}

// --- TAB 2: ABOUT (Designer Layout) ---
struct AboutSettingsView: View {
    var body: some View {
        VStack(spacing: 0) {
            // TOP SECTION: Left Icon | Right Text
            HStack(spacing: 25) {
                // Left Plane: Icon
                Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                    .resizable()
                    .frame(width: 80, height: 80)
                    .shadow(radius: 5)
                
                // Right Plane: Info
                VStack(alignment: .leading, spacing: 6) {
                    Text("Bye")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Version 1.0")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(6)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 30)
            .background(Color(nsColor: NSColor(white: 0.18, alpha: 1.0)))
            
            // BOTTOM SECTION: Links & Footer
            VStack(spacing: 0) {
                // Links
                VStack(spacing: 0) {
                    LinkRow(icon: "globe", text: "Visit Website", url: "https://google.com")
                    LinkRow(icon: "terminal.fill", text: "View Source Code", url: "https://github.com/designsbymuzeer/Bye-App-Mac")
                }
                .padding(.top, 15)
                
                Spacer()
                
                // Footer
                Text("Made with ❤️ by Abdul")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(Color(nsColor: NSColor(white: 0.12, alpha: 1.0)))
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// Helper View for the Links
struct LinkRow: View {
    let icon: String
    let text: String
    let url: String
    
    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack {
                Image(systemName: icon)
                    .frame(width: 20)
                    .foregroundColor(.white.opacity(0.7))
                Text(text)
                    .foregroundColor(.white.opacity(0.9))
                Spacer()
                Image(systemName: "arrow.up.right")
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
