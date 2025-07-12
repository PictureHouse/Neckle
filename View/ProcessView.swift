import SwiftUI

// The view shown on the screen when performing neck exercises, which is the main feature of the app.
struct ProcessView: View {
    @Binding var mainButtonState: MainButtonState
    
    // Create objects of FaceAngleManager here because it used only in this view and child views.
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
                // Start facial motion tracking when the first step begins.
                faceAngleManager.startUpdates()
            }
        case .step2:
            Step2CircleView(
                faceAngleManager: faceAngleManager,
                currentStep: $currentStep
            )
        case .step3:
            Step3CircleView(
                faceAngleManager: faceAngleManager,
                currentStep: $currentStep
            )
            .onDisappear {
                // End facial motion tracking when the last step is completed.
                faceAngleManager.stopUpdates()
            }
        case .finished:
            StepFinishedView(mainButtonState: $mainButtonState, currentStep: $currentStep)
        }
    }
}

// Enum type containing the steps of the neck exercise and the string to be displayed on the bottom main button for each step.
enum Steps: String, CustomStringConvertible {
    // The neck exercise phase consists of two steps and a completion step.
    case step1 = "Step 1"
    case step2 = "Step 2"
    case step3 = "Step 3"
    case finished = "Finished!"
    
    // The string to be displayed on the StepGuideCell for each step.
    var description: String {
        switch self {
        case .step1, .step2, .step3:
            return "Tap the circle to listen again"
        case .finished:
            return "Tap the circle to finish"
        }
    }
}

#Preview {
    ProcessView(mainButtonState: .constant(.stop))
}
