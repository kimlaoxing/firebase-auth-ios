import SwiftUI

@main
struct firebase_auth_iosApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
        }
    }
}
