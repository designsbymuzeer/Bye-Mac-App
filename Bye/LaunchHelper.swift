import Foundation
import ServiceManagement
import Combine

class LaunchHelper: ObservableObject {
    static let shared = LaunchHelper()
    
    @Published var isLaunchAtLoginEnabled: Bool = SMAppService.mainApp.status == .enabled
    
    func setLaunchAtLogin(enabled: Bool) {
        let service = SMAppService.mainApp
        let status = service.status
        
        if enabled && status == .notRegistered {
            do {
                try service.register()
                DispatchQueue.main.async {
                    self.isLaunchAtLoginEnabled = true
                }
            } catch {
                print("Failed to register launch at login: \(error)")
                self.isLaunchAtLoginEnabled = false
            }
        } else if !enabled && status == .enabled {
            do {
                try service.unregister()
                DispatchQueue.main.async {
                    self.isLaunchAtLoginEnabled = false
                }
            } catch {
                print("Failed to unregister launch at login: \(error)")
                self.isLaunchAtLoginEnabled = true
            }
        }
    }
}
