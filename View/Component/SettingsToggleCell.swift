import SwiftUI

// A component of the settings screen that change settings value using a toggle.
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
    @Previewable @State var status: Bool = true
    
    SettingsToggleCell(
        title: "Title",
        status: $status
    )
}
