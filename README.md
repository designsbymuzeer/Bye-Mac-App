<img width="120" height="120" alt="Icon 512px" src="https://github.com/user-attachments/assets/33bfcf78-0bd0-42b1-999b-a5b09b729526" />

[![Build Verification](https://github.com/designsbymuzeer/Bye-Mac-App/actions/workflows/build.yml/badge.svg)](https://github.com/designsbymuzeer/Bye-Mac-App/actions/workflows/build.yml)

# Bye 👋 - Easily Bulk close your running apps.

A native, open-source macOS utility to quit running applications instantly, built with SwiftUI.

---
[![Download](https://img.shields.io/github/v/release/designsbymuzeer/Bye-Mac-App?label=Download&style=for-the-badge)](https://github.com/designsbymuzeer/Bye-Mac-App/releases/latest)


[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE) 
[![GitHub stars](https://img.shields.io/github/stars/designsbymuzeer/Bye-Mac-App?style=social)](https://github.com/designsbymuzeer/Bye-Mac-App/stargazers)


## 💡 The Problem & The Designer's Solution

This isn't a massive project built by a seasoned developer—it's a small, cute utility born out of a simple frustration.

As a designer (I'm **designsbymuzeer**), I was tired of the hassle: after closing Figma, VS Code, and a dozen utility apps, I still had to manually hunt down every single open app to quit it and reclaim my system's focus. It felt like digital clutter was winning.

I realized I didn't need to be a "super dev" to solve this. Utilizing modern tools and a clear design vision, I built **Bye**—a tiny menu bar companion that is fast, intuitive, and visually native.

This project is simply my solution to a common community problem, and I'd love to share it with anyone who values a clean workspace. Enjoy!
## 📸 Gallery & Showcase

| Main Popover View | Settings Panel |
| :---: | :---: |
| <img width="931" height="605" alt="Main UI look" src="https://github.com/user-attachments/assets/63dade24-d967-4946-89e5-f8ae44097b31" />| <img width="412" height="605" alt="settings UI" src="https://github.com/user-attachments/assets/d0b22802-fb50-4d5d-b76a-1b16faf8d550" />|

*Showcasing the glass-morphism and clean interface.*





## ✨ Key Features

* **Native & Lightweight:** Built using modern **SwiftUI** for a minimal footprint and near-zero CPU usage when idle.
* **Instant Quitting:** Quit all running user applications with a single click.
* **Selective Control:** Easily click to select or deselect specific apps you need to keep open.
* **Adaptive Design:** Features a glass-morphic interface that seamlessly adapts to Light and Dark Mode.
* **Open Source:** Full source code available here for transparency and collaboration.

## ⬇️ Installation

### Direct Download (Recommended for Users)

1.  Download the latest **Bye.zip** file from the [Releases Page](https://github.com/designsbymuzeer/Bye-Mac-App/releases/tag/v1.0).
2.  Unzip the file.
3.  Drag the **Bye.app** file into your `/Applications` folder.
4.  **Important:** On first run, you may need to **Right-Click** the app icon and select **Open** to bypass the "Unidentified Developer" warning.

### Developer/Source Code Setup

If you wish to build the app from source:

1.  Clone this repository: `https://github.com/designsbymuzeer/Bye-Mac-App.git`
2.  Open the project file (`Bye.xcodeproj`) in **Xcode (macOS 14.5+)**.
3.  Build and Run (`⌘ + R`).

## ⚙️ Technology Stack

Bye is a modern macOS application built exclusively with Apple's native frameworks:

* **Language:** Swift 5.8+
* **Frameworks:** SwiftUI (for the UI) and AppKit (specifically `NSWorkspace` for process management).
* **Compatibility:** macOS Ventura (13.0) or newer.

## ❓ Troubleshooting & FAQ

### **Q: Why does macOS say "Bye cannot be opened because it is from an unidentified developer?"**

This happens because the app is not submitted to the Mac App Store and has not been notarized by Apple (which requires a paid developer account).

**The Fix (You only have to do this once):**

1.  Do **NOT** drag the app into your Applications folder yet.
2.  **Right-Click** the `Bye.app` file.
3.  Select **Open**.
4.  A new warning dialog will appear. Click the **Open** button to grant permission.

### **Q: Why did I have to click 'Install' when I opened the app?**

The first time the app is run, it needs permission to set up the necessary background service to monitor application changes. This is standard for menu bar utilities.

## 🤝 Contributing & License

We welcome contributions, bug reports, and feature suggestions! Feel free to open an issue or submit a pull request.

Versions released after [Nov 27, 2025] are licensed under GPLv3."

This project is licensed under the **GPLv3**.

Designed, built, and maintained for the macOS community by [designsbymuzeer](https://designsbymuzeer.framer.website/).
