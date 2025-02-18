import SwiftUI
import Observation
import CoreMotion

@Observable
final class BluetoothConnectionManager: NSObject, CMHeadphoneMotionManagerDelegate {
    private let connectionManager = CMHeadphoneMotionManager()
    var isBluetoothConnected: Bool = false
    
    override init() {
        super.init()
        setupMotionManager()
    }
    
    private func setupMotionManager() {
        connectionManager.delegate = self
        
        if connectionManager.isDeviceMotionAvailable {
            connectionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard error == nil else { return }
            }
        }
    }
    
    func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        isBluetoothConnected = true
        print("AirPods Connected")
    }
    
    func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
        isBluetoothConnected = false
        print("AirPods Disconnected")
    }
}
