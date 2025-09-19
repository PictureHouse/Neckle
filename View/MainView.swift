import SwiftUI

// Main view of the app.
struct MainView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(SpeechManager.self) private var speechManager
    
    // Create objects of BluetoothConnectionManager here because it used only in this view.
    @State private var bluetoothConnectionManager = BluetoothConnectionManager()
    @State private var mainButtonState: MainButtonState = .disabled
    @State private var mainButtonHapticTrigger: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                contents
                
                Spacer()
                
                MainButton(
                    state: mainButtonState,
                    type: userSettingsManager.audioDevice,
                    action: {
                        if mainButtonState == .play {
                            mainButtonState = .stop
                        } else {
                            mainButtonState = .play
                        }
                    }
                )
            }
            .padding(16)
            .toolbar {
                if mainButtonState != .stop {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            if #available(iOS 26.0, *) {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.teal)
                            } else {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.teal)
                            }
                        }
                    }
                }
            }
            .onAppear(perform: {
                // Check if AirPods are connected when the view appears.
                mainButtonState = bluetoothConnectionManager.isBluetoothConnected ? .play : .disabled
            })
            .onChange(of: bluetoothConnectionManager.isBluetoothConnected) {
                // Updates AirPods connection status whenever AirPods connection status changes.
                mainButtonState = bluetoothConnectionManager.isBluetoothConnected ? .play : .disabled
            }
            .onChange(of: mainButtonState) {
                speechManager.stop()
                if userSettingsManager.hapticFeedback {
                    mainButtonHapticTrigger.toggle()
                }
            }
            .sensoryFeedback(.success, trigger: mainButtonHapticTrigger)
        }
    }
}

private extension MainView {
    // Body of the main view that shows the main contents of the app.
    @ViewBuilder
    var contents: some View {
        switch mainButtonState {
        case .disabled, .play:
            HomeView()
        case .stop:
            ProcessView(mainButtonState: $mainButtonState)
        }
    }
}

#Preview {
    MainView()
        .environment(UserSettingsManager())
        .environment(SpeechManager())
}
