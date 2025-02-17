import SwiftUI

struct StepFinishedView : View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(SpeechManager.self) private var speechManager
    
    @Binding var mainButtonState: MainButtonState
    @Binding var currentStep: Steps
    
    private let circleStroke: Double = 20
    
    @State private var scripts: StepFinishedScripts = .finish
    @State private var scale: CGFloat = 1
    @State private var strokeColor: Color = .gray
    
    var body: some View {
        Circle()
            .stroke(strokeColor, lineWidth: circleStroke)
            .frame(width: 350, height: 350)
            .scaleEffect(scale)
            .overlay {
                StepGuideCell(title: currentStep.rawValue, message: currentStep.description)
            }
            .onAppear {
                speechManager.speak(text: scripts.rawValue, voice: userSettingsManager.voice)
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

private extension StepFinishedView {
    enum StepFinishedScripts: String {
        case finish = "You've completed all your neck exercises. Keep your neck healthy with simple neck exercises with Neckle!"
    }
}

#Preview {
    StepFinishedView(mainButtonState: .constant(.stop), currentStep: .constant(.finished))
        .environment(UserSettingsManager())
        .environment(SpeechManager())
}
