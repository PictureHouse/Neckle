import SwiftUI
import Observation
import CoreMotion

// Manager that checks whether AirPods are connected.
@Observable
final class BluetoothConnectionManager: NSObject, CMHeadphoneMotionManagerDelegate {
    private let connectionManager = CMHeadphoneMotionManager()
    
    // A variable that stores whether the AirPods is connected or not as a Boolean value.
    var isBluetoothConnected: Bool = false
    
    override init() {
        super.init()
        setupMotionManager()
    }
    
    // A function to setup motion update.
    private func setupMotionManager() {
        connectionManager.delegate = self
        
        if connectionManager.isDeviceMotionAvailable {
            connectionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard error == nil else { return }
            }
        }
    }
    
    // A function that changes the status of isBluetoothConnected to true when AirPods are connected.
    func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        isBluetoothConnected = true
        print("AirPods Connected")
    }
    
    // A function that changes the status of isBluetoothConnected to false when the AirPods are disconnected.
    func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
        isBluetoothConnected = false
        print("AirPods Disconnected")
    }
}
