import SwiftUI

@main
struct NeckleApp: App {
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
