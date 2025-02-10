import SwiftUI

struct Step1CircleView: View {
    @Binding var currentStep: Steps
    @Binding var circleStroke: Double
    
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                .frame(width: 350, height: 350)
                .rotationEffect(.degrees(270))
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: progress)
                        .stroke(Color.teal, style: StrokeStyle(lineWidth: circleStroke, lineCap: .square))
                        .rotationEffect(.degrees(270))
                )
            
            Text(currentStep.rawValue)
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.teal)
            
            VStack {
                Spacer()
                Slider(value: $progress, in: 0...1)
                .padding()
            }
        }
        .onChange(of: progress) {
            if progress == 1 {
                currentStep = .step2
            }
        }
    }
}

#Preview {
    Step1CircleView(currentStep: .constant(Steps.step1), circleStroke: .constant(20))
}
