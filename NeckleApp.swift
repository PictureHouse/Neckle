import SwiftUI

@main
struct NeckleApp: App {
    // Create objects of each Manager to use as an environment.
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
