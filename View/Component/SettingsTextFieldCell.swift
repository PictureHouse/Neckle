import SwiftUI

struct SettingsTextFieldCell: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
            
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 40)
                .foregroundStyle(.ultraThinMaterial)
                .overlay {
                    TextField(placeholder, text: $text)
                        .padding()
                        .foregroundStyle(.teal)
                        .submitLabel(.done)
                }
                .padding(.bottom, 8)
            
            Divider()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SettingsTextFieldCell(
        title: "Title",
        placeholder: "Enter text",
        text: .constant("Text")
    )
}
