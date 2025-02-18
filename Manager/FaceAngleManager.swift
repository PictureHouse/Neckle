import SwiftUI
import Observation
import CoreMotion

@Observable
final class FaceAngleManager {
    private let motionManager = CMHeadphoneMotionManager()
    
    var pitch: Double = 0.0
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
        yaw = motion.attitude.yaw
    }
    
    func startUpdates() {
        motionManager.startDeviceMotionUpdates()
    }
    
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
