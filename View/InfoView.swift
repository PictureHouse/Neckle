import SwiftUI

struct InfoView: View {
    @State private var circleStroke: Double = 10
    
    var body: some View {
        Circle()
            .stroke(.teal, lineWidth: circleStroke)
            .frame(width: 350, height: 350)
            .onAppear {
                withAnimation(.linear.repeatForever(autoreverses: true).speed(0.4)) {
                    circleStroke = 20
                }
            }
            .overlay {
                VStack(spacing: 16) {
                    Text("Neckle")
                        .font(.system(size: 48, weight: .bold))
                    
                    Text("30 seconds of neck exercise every day,\nthe secret to maintaining a healthy neck")
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                }
                .foregroundStyle(.teal)
            }
    }
}

#Preview {
    InfoView()
}
