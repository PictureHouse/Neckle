import SwiftUI

struct Step2CircleView: View {
    @Binding var currentStep: Steps
    @Binding var circleStroke: Double
    
    @State private var leftProgress: CGFloat = 0.0
    @State private var rightProgress: CGFloat = 0.0
    
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
            
            Text(currentStep.rawValue)
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.teal)
            
            VStack {
                Spacer()
                HStack {
                    Slider(value: $leftProgress, in: 0...1)
                    Slider(value: $rightProgress, in: 0...1)
                }
                .padding()
            }
        }
        .onChange(of: rightProgress) {
            if leftProgress * rightProgress == 1 {
                currentStep = .step1
            }
        }
    }
}

#Preview {
    Step2CircleView(currentStep: .constant(Steps.step2), circleStroke: .constant(20))
}
