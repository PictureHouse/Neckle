import SwiftUI

@main
struct NeckleApp: App {
    @State private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(mainViewModel)
        }
    }
}
