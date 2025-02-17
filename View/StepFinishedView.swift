import SwiftUI

struct StepFinishedView : View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(SpeechManager.self) private var speechManager
    
    @Binding var mainButtonState: MainButtonState
    @Binding var currentStep: Steps
    
    private let circleStroke: Double = 20
    
    @State private var scripts: StepFinishedScripts = .finish
    
    var body: some View {
        Circle()
            .stroke(.teal, lineWidth: circleStroke)
            .frame(width: 350, height: 350)
            .overlay {
                StepGuideCell(title: currentStep.rawValue, message: currentStep.description)
            }
            .onAppear {
                speechManager.speak(text: scripts.rawValue, voice: userSettingsManager.voice)
            }
            .onTapGesture {
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
