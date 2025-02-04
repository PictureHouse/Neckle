import SwiftUI

struct SettingsToggleCell: View {
    let title: String
    let image: String
    @Binding var status: Bool
    
    var body: some View {
        VStack {
            HStack {
                Label(title, systemImage: image)
                    .bold()
                
                Spacer()
                
                Toggle(isOn: $status) { }
                    .tint(.teal)
            }
            
            Divider()
        }
    }
}

#Preview {
    SettingsToggleCell(
        title: "Title",
        image: "person.fill",
        status: .constant(true)
    )
}
