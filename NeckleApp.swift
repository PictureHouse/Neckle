import SwiftUI
import SwiftData

@main
struct NeckleApp: App {
    @State private var bluetoothConnectionManager = BluetoothConnectionManager()
    @State private var speechManager = SpeechManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: UserModel.self)
                .environment(bluetoothConnectionManager)
                .environment(speechManager)
        }
    }
}
