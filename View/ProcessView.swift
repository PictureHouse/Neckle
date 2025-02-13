import SwiftUI

struct ProcessView: View {
    @Environment(SpeechManager.self) private var speechManager
    @Environment(FaceAngleManager.self) private var faceAngleManager
    
    @State private var currentStep: Steps = .step1
    @State private var circleStroke: Double = 10
    
    var body: some View {
        switch currentStep {
        case .step1:
            Step1CircleView(currentStep: $currentStep, circleStroke: $circleStroke)
                .onAppear {
                    withAnimation(.linear.repeatForever(autoreverses: true).speed(0.4)) {
                        circleStroke = 20
                    }
                    
                    faceAngleManager.startUpdates()
                }
        case .step2:
            Step2CircleView(currentStep: $currentStep, circleStroke: $circleStroke)
                .onAppear {
                    withAnimation(.linear.repeatForever(autoreverses: true).speed(0.4)) {
                        circleStroke = 20
                    }
                }
                .onDisappear {
                    faceAngleManager.stopUpdates()
                }
        }
    }
}

enum Steps: String, CustomStringConvertible {
    case step1 = "Step 1"
    case step2 = "Step 2"
    
    var description: String {
        switch self {
        case .step1:
            return "Okay, Let's start."
        case .step2:
            return ""
        }
    }
}

#Preview {
    ProcessView()
        .environment(SpeechManager())
        .environment(FaceAngleManager())
}
