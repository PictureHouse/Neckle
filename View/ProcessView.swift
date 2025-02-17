import SwiftUI

struct ProcessView: View {
    @Binding var mainButtonState: MainButtonState
    
    @State private var faceAngleManager = FaceAngleManager()
    @State private var currentStep: Steps = .step1
    
    var body: some View {
        switch currentStep {
        case .step1:
            Step1CircleView(
                faceAngleManager: faceAngleManager,
                currentStep: $currentStep
            )
            .onAppear {
                faceAngleManager.startUpdates()
            }
        case .step2:
            Step2CircleView(
                faceAngleManager: faceAngleManager,
                currentStep: $currentStep
            )
            .onDisappear {
                faceAngleManager.stopUpdates()
            }
        case .finished:
            StepFinishedView(mainButtonState: $mainButtonState, currentStep: $currentStep)
        }
    }
}

enum Steps: String, CustomStringConvertible {
    case step1 = "Step 1"
    case step2 = "Step 2"
    case finished = "Finished!"
    
    var description: String {
        switch self {
        case .step1, .step2:
            return "Tap the circle to listen again"
        case .finished:
            return "Tap the circle to finish"
        }
    }
}

#Preview {
    ProcessView(mainButtonState: .constant(.stop))
}
