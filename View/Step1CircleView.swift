import SwiftUI

// View of the neck exercise in Step 1.
struct Step1CircleView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(SpeechManager.self) private var speechManager
    
    @Bindable var faceAngleManager: FaceAngleManager
    @Binding var currentStep: Steps
    
    @State private var currentScript: Step1Scripts = .upGuide
    @State private var upProgress: CGFloat = 0.0
    @State private var downProgress: CGFloat = 0.0
    @State private var upTimer: Timer? = nil
    @State private var downTimer: Timer? = nil
    @State private var isUpCompleted: Bool = false
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
                .rotationEffect(.degrees(180))
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: upProgress / 2)
                        .stroke(Color.teal, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                        .rotationEffect(.degrees(180))
                )
            
            Circle()
                .trim(from: 0.5, to: 1.0)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                .frame(width: 350, height: 350)
                .rotationEffect(.degrees(180))
                .overlay(
                    Circle()
                        .trim(from: 0.5, to: 0.5 + (downProgress / 2))
                        .stroke(Color.teal, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                        .rotationEffect(.degrees(180))
                )
            
            StepGuideCell(title: currentStep.rawValue, message: currentStep.description)
        }
        .onAppear {
            speechManager.speak(text: currentScript.rawValue, voice: userSettingsManager.voice)
        }
        .onChange(of: downProgress) {
            if downProgress == 1 {
                currentStep = .step2
            }
        }
        .onChange(of: currentScript) {
            speechManager.speak(text: currentScript.rawValue, voice: userSettingsManager.voice)
        }
        .onTapGesture {
            speechManager.stop()
            speechManager.speak(text: currentScript.rawValue, voice: userSettingsManager.voice)
        }
        .onReceive(timer) { _ in
            step1Process()
        }
        .sensoryFeedback(.success, trigger: successTrigger)
        .sensoryFeedback(.increase, trigger: userSettingsManager.hapticFeedback ? upProgress : nil)
        .sensoryFeedback(.increase, trigger: userSettingsManager.hapticFeedback ? downProgress : nil)
    }
}

private extension Step1CircleView {
    // A function that changes the progress of the neck exercise through facial motion and a timer in the neck exercise performed in Step 1.
    func step1Process() {
        if !isUpCompleted {
            if faceAngleManager.pitch > userSettingsManager.pitchIntensity {
                if upTimer == nil {
                    upTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        if upProgress < 1 {
                            withAnimation {
                                upProgress += 0.033
                            }
                        } else {
                            if userSettingsManager.hapticFeedback {
                                successTrigger.toggle()
                            }
                            speechManager.stop()
                            upTimer?.invalidate()
                            upTimer = nil
                            isUpCompleted = true
                            currentScript = .downGuide
                        }
                    }
                }
            } else {
                upTimer?.invalidate()
                upTimer = nil
            }
        } else {
            if faceAngleManager.pitch < -userSettingsManager.pitchIntensity {
                if downTimer == nil {
                    downTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        if downProgress < 1 {
                            withAnimation {
                                downProgress += 0.033
                            }
                        } else {
                            if userSettingsManager.hapticFeedback {
                                successTrigger.toggle()
                            }
                            speechManager.stop()
                            downTimer?.invalidate()
                            downTimer = nil
                            currentStep = .step2
                        }
                    }
                }
            } else {
                downTimer?.invalidate()
                downTimer = nil
            }
        }
    }
}

private extension Step1CircleView {
    // An enum type containing the script to be spoken through SpeechManager in step 1.
    enum Step1Scripts: String {
        case upGuide = "Welcome. Now let's start some simple neck exercises with voice guide. Please listen carefully to the audio guide and follow it. First, tilt your head back and look up for 3 seconds."
        case downGuide = "Good! Next, bow your head and look down for 3 seconds."
    }
}

#Preview {
    Step1CircleView(
        faceAngleManager: FaceAngleManager(),
        currentStep: .constant(Steps.step1)
    )
    .environment(UserSettingsManager())
    .environment(SpeechManager())
}
