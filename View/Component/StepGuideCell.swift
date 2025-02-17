import SwiftUI

struct StepGuideCell: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.system(size: 48, weight: .bold))
            
            Text(message)
                .lineSpacing(5)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.teal)
    }
}

#Preview {
    StepGuideCell(title: "Title", message: "Message")
}
