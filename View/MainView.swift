import SwiftUI

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
                            speechManager.stop()
                            mainButtonState = .play
                        }
                    }
                )
            }
            .padding(16)
            .background(.black.opacity(0.95))
            .onAppear(perform: {
                mainButtonState = bluetoothConnectionManager.isBluetoothConnected ? .play : .disabled
            })
            .onChange(of: bluetoothConnectionManager.isBluetoothConnected) {
                mainButtonState = bluetoothConnectionManager.isBluetoothConnected ? .play : .disabled
            }
            .onChange(of: mainButtonState) {
                if userSettingsManager.hapticFeedback {
                    mainButtonHapticTrigger.toggle()
                }
            }
            .sensoryFeedback(.success, trigger: mainButtonHapticTrigger)
        }
    }
}

private extension MainView {
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
