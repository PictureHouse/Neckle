import SwiftUI

struct MainView: View {
    @Environment(BluetoothConnectionManager.self) private var bluetoothConnectionManager
    
    @State private var showInfo = false
    @State private var mainButtonState: MainButtonState = .disabled
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                
                Spacer()
                
                ProcessCircleView()
                
                Spacer()
                
                MainButton(
                    state: mainButtonState,
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
                mainButtonState = bluetoothConnectionManager.isBluetoothConnected ? .play : .disabled
            })
            .onChange(of: bluetoothConnectionManager.isBluetoothConnected) {
                mainButtonState = bluetoothConnectionManager.isBluetoothConnected ? .play : .disabled
            }
            .sheet(isPresented: $showInfo) {
                InfoView()
            }
        }
    }
}

extension MainView {
    private var header: some View {
        HStack(spacing: 16) {
            Spacer()
            
            Button {
                showInfo = true
            } label: {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.teal)
            }
            
            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.teal)
            }
        }
    }
}

#Preview {
    MainView()
        .environment(BluetoothConnectionManager())
}
