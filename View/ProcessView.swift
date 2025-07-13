import SwiftUI

// The view shown on the screen when performing neck exercises, which is the main feature of the app.
struct ProcessView: View {
    @Binding var mainButtonState: MainButtonState
    
    // Create objects of FaceAngleManager here because it used only in this view and child views.
    @State private var faceAngleManager = FaceAngleManager()
    @State private var currentStep: Steps = .step1_up
    
    var body: some View {
        VStack {
            switch currentStep {
            case .step1_up, .step1_down:
                Step1CircleView(faceAngleManager: faceAngleManager, currentStep: $currentStep)
            case .step2_left, .step2_right:
                Step2CircleView(faceAngleManager: faceAngleManager, currentStep: $currentStep)
            case .step3_left, .step3_right:
                Step3CircleView(faceAngleManager: faceAngleManager, currentStep: $currentStep)
            case .finished:
                StepFinishedView(mainButtonState: $mainButtonState, currentStep: $currentStep)
            }
        }
        .onAppear {
            // Start facial motion tracking when the first step begins.
            faceAngleManager.startUpdates()
        }
        .onDisappear {
            // End facial motion tracking when the last step is completed.
            faceAngleManager.stopUpdates()
        }
    }
}

// Enum type containing the steps of the neck exercise and the string to be displayed on the bottom main button for each step.
enum Steps: String, CustomStringConvertible {
    // The neck exercise phase consists of two steps and a completion step.
    case step1_up = "step1_up"
    case step1_down = "step1_down"
    case step2_left = "step2_left"
    case step2_right = "step2_right"
    case step3_left = "step3_left"
    case step3_right = "step3_right"
    case finished = "neck_healthy"
    
    // The string to be displayed on the StepGuideCell for each step.
    var buttonText: String {
        switch self {
        case .step1_up, .step1_down, .step2_left, .step2_right, .step3_left, .step3_right:
            return "Tap the circle to listen again"
        case .finished:
            return "Tap the circle to finish"
        }
    }
    
    var description: String {
        switch self {
        case .step1_up:
            return "Welcome. Now let's start some simple neck exercises with voice guide. Please listen carefully to the audio guide and follow it. First, tilt your head back and look up for 3 seconds."
        case .step1_down:
            return "Good! Next, bow your head and look down for 3 seconds."
        case .step2_left:
            return "You have completed Step 1! Now move on to Step 2. Turn your head to the left and hold for 3 seconds."
        case .step2_right:
            return "You are doing well. Then, turn your head to the right and hold for 3 seconds."
        case .step3_left:
            return "You have completed Step 2! Now move on to Step 3. Raise your left arm over your head, and gently pull your head toward your left shoulder to stretch the right side of your neck for 3 seconds."
        case .step3_right:
            return "Nice. Then, raise your right arm over your head, and gently pull your head toward your right shoulder to stretch the left side of your neck for 3 seconds."
        case .finished:
            return "You have completed all your neck exercises. Keep your neck healthy with simple neck exercises with Neckle. Have a nice day!"
        }
    }
}

#Preview {
    ProcessView(mainButtonState: .constant(.stop))
}
