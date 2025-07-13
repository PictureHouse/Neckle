import SwiftUI

// A component that displays an image and message in a circle for each step.
struct StepGuideCell: View {
    let image: String
    let message: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            
            Text(message)
                .font(.system(size: 16))
                .lineSpacing(5)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.teal)
    }
}

#Preview {
    StepGuideCell(image: "step1_left", message: "Message")
}
