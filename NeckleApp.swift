import SwiftUI

@main
struct NeckleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var userSettingsManager = UserSettingsManager()
    @State private var bluetoothConnectionManager = BluetoothConnectionManager()
    @State private var speechManager = SpeechManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(userSettingsManager)
                .environment(bluetoothConnectionManager)
                .environment(speechManager)
        }
    }
}
