import SwiftUI

// View of the neck exercise in Step 3.
struct Step3CircleView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(SpeechManager.self) private var speechManager
    
    @Bindable var faceAngleManager: FaceAngleManager
    @Binding var currentStep: Steps
    
    @State private var leftProgress: CGFloat = 0.0
    @State private var rightProgress: CGFloat = 0.0
    @State private var leftTimer: Timer? = nil
    @State private var rightTimer: Timer? = nil
    @State private var isLeftCompleted: Bool = false
    @State private var successTrigger: Bool = false
    
    private let circleStroke: CGFloat = 20
    private let duration: TimeInterval = 3
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.5)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                .frame(width: 350, height: 350)
                .rotationEffect(.degrees(90))
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: leftProgress / 2)
                        .stroke(Color.teal, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                        .rotationEffect(.degrees(90))
                )
            
            Circle()
                .trim(from: 0.5, to: 1.0)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                .frame(width: 350, height: 350)
                .rotationEffect(.degrees(90))
                .overlay(
                    Circle()
                        .trim(from: 0.5, to: 0.5 + (rightProgress / 2))
                        .stroke(Color.teal, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                        .rotationEffect(.degrees(90))
                )
            
            StepGuideCell(image: currentStep.rawValue, message: currentStep.buttonText)
        }
        .onAppear {
            speechManager.speak(text: currentStep.description, voice: userSettingsManager.voice)
        }
        .onChange(of: rightProgress) {
            if rightProgress == 1 {
                currentStep = .finished
            }
        }
        .onChange(of: currentStep) {
            speechManager.speak(text: currentStep.description, voice: userSettingsManager.voice)
        }
        .onTapGesture {
            speechManager.stop()
            speechManager.speak(text: currentStep.description, voice: userSettingsManager.voice)
        }
        .onReceive(timer) { _ in
            step3Process()
        }
        .sensoryFeedback(.success, trigger: successTrigger)
        .sensoryFeedback(.increase, trigger: userSettingsManager.hapticFeedback ? leftProgress : nil)
        .sensoryFeedback(.increase, trigger: userSettingsManager.hapticFeedback ? rightProgress : nil)
    }
}

private extension Step3CircleView {
    // A function that changes the progress of the neck exercise through facial motion and a timer in the neck exercise performed in Step 3.
    func step3Process() {
        if !isLeftCompleted {
            if faceAngleManager.roll < -userSettingsManager.rollIntensity {
                if leftTimer == nil {
                    leftTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        if leftProgress < 1 {
                            withAnimation {
                                leftProgress += 0.033
                            }
                        } else {
                            if userSettingsManager.hapticFeedback {
                                successTrigger.toggle()
                            }
                            speechManager.stop()
                            leftTimer?.invalidate()
                            leftTimer = nil
                            isLeftCompleted = true
                            currentStep = .step3_right
                        }
                    }
                }
            } else {
                leftTimer?.invalidate()
                leftTimer = nil
            }
        } else {
            if faceAngleManager.roll > userSettingsManager.rollIntensity {
                if rightTimer == nil {
                    rightTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        if rightProgress < 1 {
                            withAnimation {
                                rightProgress += 0.033
                            }
                        } else {
                            if userSettingsManager.hapticFeedback {
                                successTrigger.toggle()
                            }
                            speechManager.stop()
                            rightTimer?.invalidate()
                            rightTimer = nil
                            currentStep = .finished
                        }
                    }
                }
            } else {
                rightTimer?.invalidate()
                rightTimer = nil
            }
        }
    }
}

#Preview {
    Step3CircleView(faceAngleManager: FaceAngleManager(), currentStep: .constant(Steps.step3_left))
        .environment(UserSettingsManager())
        .environment(SpeechManager())
}
