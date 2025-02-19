import SwiftUI

@main
struct NeckleApp: App {
    // Create objects of each Manager to use as an environment because these objects will be used in multiple views.
    @State private var userSettingsManager = UserSettingsManager()
    @State private var speechManager = SpeechManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(userSettingsManager)
                .environment(speechManager)
        }
    }
}
