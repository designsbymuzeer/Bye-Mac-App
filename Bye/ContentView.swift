//
//  Bye - Quit running apps easy!
//  Created by Abdul (designsbymuzeer)
//
//  Designed and Developed with ❤️.
//  Copyright © 2025 designsbymuzeer. All rights reserved.
//

import SwiftUI
import AppKit

// 1. The Data Structure
struct AppItem: Identifiable, Equatable {
    let id: String
    let app: NSRunningApplication
    var isSelected: Bool = false
    
    static func == (lhs: AppItem, rhs: AppItem) -> Bool {
        return lhs.id == rhs.id && lhs.isSelected == rhs.isSelected
    }
}

struct ContentView: View {
    @State private var appItems: [AppItem] = []
    @Environment(\.openSettings) var openSettings
    
    // UI States
    @State private var showQuitConfirmation = false
    @State private var isHoveringQuit = false
    
    // Helpers
    @StateObject private var launchHelper = LaunchHelper.shared
    
    let columns = [GridItem(.adaptive(minimum: 65))]
    
    var selectedApps: [AppItem] {
        appItems.filter { $0.isSelected }
    }

    var body: some View {
        ZStack {
            // 1. THE GLASS BACKGROUND
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            // --- LAYER 1: Main UI ---
            VStack(spacing: 0) {
                
                // HEADER (Gear Icon, App Count)
                HStack {
                    Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                        .resizable().frame(width: 24, height: 24)
                    Text("Bye").font(.system(size: 18, weight: .semibold, design: .default)).foregroundColor(.primary)
                    Spacer()
                    Text("\(appItems.count) Apps").font(.caption).foregroundColor(.secondary).padding(.trailing, 8)
                    
                    Button(action: {
                        openSettings()
                        NSApplication.shared.activate(ignoringOtherApps: true) // Fixes window opening behind
                    }) {
                        Image(systemName: "gearshape").font(.system(size: 16)).foregroundColor(.secondary)
                    }.buttonStyle(.plain)
                }
                .padding(16)
                .opacity(showQuitConfirmation ? 0.3 : 1)
                
                // THE GRID (App Icons)
                ScrollView {
                    if appItems.isEmpty {
                        VStack { Spacer(); Text("No apps running").foregroundColor(.secondary); Spacer() }.frame(height: 200)
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach($appItems) { $item in
                                AppIconView(item: $item)
                            }
                        }
                        .padding(.horizontal).padding(.bottom, 10)
                    }
                }
                .frame(maxHeight: .infinity)
                .opacity(showQuitConfirmation ? 0.3 : 1)
                
                // FOOTER (Quit Selected Button)
                VStack(spacing: 8) {
                    Button(action: { withAnimation(.spring()) { showQuitConfirmation = true } }) {
                        Text(selectedApps.isEmpty ? "Quit all apps !" : "Quit \(selectedApps.count) apps")
                            .font(.system(size: 14, weight: .medium)).foregroundColor(.white).frame(maxWidth: .infinity).padding(.vertical, 10).background(
                                RoundedRectangle(cornerRadius: 10).fill(LinearGradient(colors: [Color(red: 0.8, green: 0.2, blue: 0.2), Color.red], startPoint: .top, endPoint: .bottom))
                                    .shadow(color: Color.red.opacity(0.3), radius: 5, y: 2)
                            ).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.2), lineWidth: 1))
                    }.buttonStyle(.plain).disabled(showQuitConfirmation)
                    
                    Text("Close your running apps easy!").font(.system(size: 10)).foregroundColor(.secondary.opacity(0.7))
                }
                .padding(12).background(.ultraThinMaterial).opacity(showQuitConfirmation ? 0.3 : 1)
                
                // DEDICATED QUIT BUTTON
                Button(action: { NSApplication.shared.terminate(nil) }) {
                    Text("Quit the Bye App").font(.system(size: 10))
                        .foregroundColor(isHoveringQuit ? .red : .gray)
                        .underline(isHoveringQuit, color: .red)
                }
                .onHover { hovered in isHoveringQuit = hovered }
                .buttonStyle(.borderless)
                .padding(.top, 5).padding(.bottom, 8)

            }
            .transition(.opacity) // Smooth content fade
            
            // --- LAYER 2: Custom Alert ---
            if showQuitConfirmation {
                ZStack {
                    Color.black.opacity(0.01).ignoresSafeArea().onTapGesture { withAnimation { showQuitConfirmation = false } }
                    
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill").font(.title).foregroundColor(.orange)
                        Text("Are you sure?").font(.headline)
                        Text(selectedApps.isEmpty ? "This will quit ALL running user apps." : "This will quit the \(selectedApps.count) selected apps.").font(.caption).multilineTextAlignment(.center).foregroundColor(.secondary).padding(.horizontal)
                        
                        HStack(spacing: 10) {
                            Button("Cancel") { withAnimation { showQuitConfirmation = false } }.buttonStyle(.bordered)
                            Button("Quit") { handleQuitAction(); withAnimation { showQuitConfirmation = false } }.buttonStyle(.borderedProminent).tint(.red)
                        }
                    }
                    .padding().frame(width: 260).background(.thickMaterial).cornerRadius(16).shadow(radius: 10).transition(.scale.combined(with: .opacity))
                }
            }
        }
        .frame(width: 320, height: 400)
        // Note: VisualEffectView is not required here, use .ultraThinMaterial on ZStack background
        .background(Rectangle().fill(.ultraThinMaterial).ignoresSafeArea())
        .onAppear(perform: setupApp)
    }
    
    // --- SUBVIEW: App Icon in Grid ---
    struct AppIconView: View {
        @Binding var item: AppItem
        
        var body: some View {
            VStack {
                ZStack {
                    if let icon = item.app.icon {
                        Image(nsImage: icon).resizable().frame(width: 44, height: 44)
                    }
                }
                .padding(4).background(RoundedRectangle(cornerRadius: 12).fill(item.isSelected ? Color.red.opacity(0.1) : Color.clear))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(item.isSelected ? Color.red : Color.clear, lineWidth: 1.5))
                .contentShape(Rectangle())
                .onTapGesture { item.isSelected.toggle() }
                .contextMenu {
                    Button(role: .destructive) { item.app.terminate() } label: { Label("Quit Immediately", systemImage: "xmark.circle") }
                }
                
                Text(item.app.localizedName ?? "App").font(.system(size: 11)).lineLimit(1).foregroundColor(item.isSelected ? .red : .secondary)
            }
        }
    }
    
    // --- LOGIC FUNCTIONS ---
    func setupApp() {
        fetchApps()
        NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace.didLaunchApplicationNotification, object: nil, queue: .main) { _ in fetchApps() }
        NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace.didTerminateApplicationNotification, object: nil, queue: .main) { _ in fetchApps() }
    }
    
    func fetchApps() {
        DispatchQueue.global(qos: .userInitiated).async {
            let allApps = NSWorkspace.shared.runningApplications
            
            let newItems = allApps.compactMap { app -> AppItem? in
                guard app.activationPolicy == .regular, let bid = app.bundleIdentifier, app.localizedName != "Bye" else { return nil }
                return AppItem(id: bid, app: app, isSelected: false)
            }
            let sortedItems = newItems.sorted { ($0.app.localizedName ?? "") < ($1.app.localizedName ?? "") }
            
            DispatchQueue.main.async {
                let currentSelections = self.appItems.filter { $0.isSelected }.map { $0.id }
                self.appItems = sortedItems.map { item in
                    var modified = item
                    if currentSelections.contains(item.id) { modified.isSelected = true }
                    return modified
                }
            }
        }
    }
    
    func handleQuitAction() {
        if selectedApps.isEmpty { for item in appItems { item.app.terminate() } } else { for item in selectedApps { item.app.terminate() } }
    }
}
