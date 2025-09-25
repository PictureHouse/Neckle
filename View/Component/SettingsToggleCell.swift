import SwiftUI

// A component of the settings screen that change settings value using a toggle.
struct SettingsToggleCell: View {
    let title: String
    @Binding var status: Bool
    
    var body: some View {
        Toggle(isOn: $status) {
            Text(title)
                .font(.system(size: 14))
        }
        .tint(.teal)
    }
}

#Preview {
    @Previewable @State var status: Bool = true
    
    SettingsToggleCell(
        title: "Title",
        status: $status
    )
}
