import SwiftUI

// Main view of the app.
struct MainView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(BluetoothConnectionManager.self) private var bluetoothConnectionManager
    @Environment(SpeechManager.self) private var speechManager
    
    @State private var mainButtonState: MainButtonState = .disabled
    @State private var mainButtonHapticTrigger: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                    .opacity(mainButtonState == .stop ? 0 : 1)
                
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
            .background(.black.opacity(0.95))
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
    // Header of the main view.
    var header: some View {
        HStack(spacing: 16) {
            Spacer()
            
            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.teal)
            }
            .tint(.teal)
            .navigationTitle("")
        }
    }
    
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
        .environment(BluetoothConnectionManager())
        .environment(SpeechManager())
}
