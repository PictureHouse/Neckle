import SwiftUI

struct SettingsToggleCell: View {
    let title: String
    @Binding var status: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $status) {
                Text(title)
                    .bold()
            }
            .tint(.teal)
            .padding(.bottom, 8)
            
            Divider()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SettingsToggleCell(
        title: "Title",
        status: .constant(true)
    )
}
