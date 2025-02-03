import SwiftUI

struct MainView: View {
    @Environment(MainViewModel.self) private var mainViewModel
    
    @State private var showInfo = false
    @State private var mainButtonState: MainButtonState = .disabled
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showInfo = true
                } label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.teal)
                }
            }
            
            Spacer()
            
            //ProgressCircleView
            
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
            mainButtonState = mainViewModel.isBluetoothConnected ? .play : .disabled
        })
        .onChange(of: mainViewModel.isBluetoothConnected) {
            mainButtonState = mainViewModel.isBluetoothConnected ? .play : .disabled
        }
        .sheet(isPresented: $showInfo) {
            InfoView()
        }
    }
}

#Preview {
    MainView()
}
