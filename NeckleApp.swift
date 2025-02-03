import SwiftUI

@main
struct NeckleApp: App {
    @State private var bluetoothConnectionManager = BluetoothConnectionManager()
    @State private var speechManager = SpeechManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(bluetoothConnectionManager)
                .environment(speechManager)
        }
    }
}
