import SwiftUI
import AVFoundation
import Combine

@Observable
class BluetoothConnectionManager {
    var isBluetoothConnected: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupNotifications()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.publisher(for: AVAudioSession.routeChangeNotification)
            .sink { [weak self] _ in
                self?.checkAudioRoute()
            }
            .store(in: &cancellables)
        
        checkAudioRoute()
    }
    
    private func checkAudioRoute() {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        isBluetoothConnected = currentRoute.outputs.contains {
            $0.portType == .bluetoothA2DP || $0.portType == .bluetoothLE || $0.portType == .bluetoothHFP
        }
    }
}
