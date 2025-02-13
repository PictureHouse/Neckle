import SwiftUI
import CoreMotion
import Combine

@Observable
final class FaceAngleManager {
    private let motionManager = CMHeadphoneMotionManager()
    private var cancellables = Set<AnyCancellable>()
    
    var pitch: Double = 0.0
    var roll: Double = 0.0
    var yaw: Double = 0.0
    
    init() {
        setupMotionUpdates()
    }
    
    private func setupMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Headphone motion is not available")
            return
        }
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let motion = motion, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self?.updateAngles(from: motion)
        }
    }
    
    private func updateAngles(from motion: CMDeviceMotion) {
        pitch = motion.attitude.pitch
        roll = motion.attitude.roll
        yaw = motion.attitude.yaw
    }
    
    func startUpdates() {
        motionManager.startDeviceMotionUpdates()
    }
    
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
