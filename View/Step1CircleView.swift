import SwiftUI

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
    }
}

private extension Step1CircleView {
    func step1Process() {
        if !isUpCompleted {
            if faceAngleManager.pitch > 0.5 {
                if upTimer == nil {
                    upTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        if upProgress < 1 {
                            withAnimation {
                                upProgress += 0.033
                            }
                        } else {
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
            if faceAngleManager.pitch < -0.5 {
                if downTimer == nil {
                    downTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        if downProgress < 1 {
                            withAnimation {
                                downProgress += 0.033
                            }
                        } else {
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
    enum Step1Scripts: String {
        case upGuide = "Welcome. Now let's start some simple neck exercises with Neckle's voice guide. First, tilt your head back and look up for three seconds."
        case downGuide = "Next, bow your head and look down for 3 seconds."
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
