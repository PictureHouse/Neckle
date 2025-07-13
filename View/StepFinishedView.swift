import SwiftUI

// The view that appears when the user has completed all the steps of the neck exercise.
struct StepFinishedView : View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(SpeechManager.self) private var speechManager
    
    @Binding var mainButtonState: MainButtonState
    @Binding var currentStep: Steps
    
    private let circleStroke: Double = 20
    
    @State private var scale: CGFloat = 1
    @State private var strokeColor: Color = .gray
    
    var body: some View {
        Circle()
            .stroke(strokeColor, lineWidth: circleStroke)
            .frame(width: 350, height: 350)
            .scaleEffect(scale)
            .overlay {
                StepGuideCell(image: currentStep.rawValue, message: currentStep.buttonText)
            }
            .onAppear {
                speechManager.speak(text: currentStep.description, voice: userSettingsManager.voice)
                withAnimation(.linear(duration: 0.7)) {
                    scale = 0.8
                    strokeColor = .teal
                }
            }
            .onTapGesture {
                speechManager.stop()
                mainButtonState = .play
            }
    }
}

#Preview {
    StepFinishedView(mainButtonState: .constant(.stop), currentStep: .constant(.finished))
        .environment(UserSettingsManager())
        .environment(SpeechManager())
}
