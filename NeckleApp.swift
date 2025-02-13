import SwiftUI

@main
struct NeckleApp: App {
    @State private var userSettingsManager = UserSettingsManager()
    @State private var bluetoothConnectionManager = BluetoothConnectionManager()
    @State private var speechManager = SpeechManager()
    @State private var faceAngleManager = FaceAngleManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(userSettingsManager)
                .environment(bluetoothConnectionManager)
                .environment(speechManager)
                .environment(faceAngleManager)
        }
    }
}
