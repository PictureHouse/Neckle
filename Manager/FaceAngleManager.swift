import SwiftUI
import Observation
import CoreMotion

// Manager that tracks facial movements using the AirPod's motion sensor.
@Observable
final class FaceAngleManager {
    private let motionManager = CMHeadphoneMotionManager()
    
    // The up and down rotation value of the head.
    var pitch: Double = 0.0
    
    // The left and right rotation value of the head.
    var yaw: Double = 0.0
    
    // The left and right tilt value of the head.
    var roll: Double = 0.0
    
    init() {
        setupMotionUpdates()
    }
    
    // A function to setup motion update.
    private func setupMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else {
            print("AirPods motion is not available")
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
    
    // A function to perform motion update for pitch and yaw.
    private func updateAngles(from motion: CMDeviceMotion) {
        pitch = motion.attitude.pitch
        yaw = motion.attitude.yaw
        roll = motion.attitude.roll
    }
    
    // A function to start motion update.
    func startUpdates() {
        motionManager.startDeviceMotionUpdates()
    }
    
    // A function to stop motion update.
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
