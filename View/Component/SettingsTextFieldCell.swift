import SwiftUI

struct SettingsTextFieldCell: View {
    let title: String
    let image: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Label(title, systemImage: image)
                .bold()
            
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 40)
                .foregroundStyle(.thickMaterial)
                .overlay {
                    TextField(placeholder, text: $text)
                        .foregroundStyle(.teal)
                }
            
            Divider()
        }
    }
}

#Preview {
    SettingsTextFieldCell(
        title: "Title",
        image: "person.fill",
        placeholder: "Enter text",
        text: .constant("Text")
    )
}
