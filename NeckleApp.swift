import SwiftUI

@main
struct NeckleApp: App {
    @State private var bluetoothConnectionManager = BluetoothConnectionManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(bluetoothConnectionManager)
        }
    }
}
