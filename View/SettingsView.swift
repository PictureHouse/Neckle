import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            HStack {
                Toggle("test", isOn: .constant(true))
            }
            .tint(.teal)
            
            Spacer()
            
            Text("version 1.0.0")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
        .padding(16)
        .foregroundStyle(.white)
        .background(.black.opacity(0.95))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .bold()
                    .foregroundStyle(.teal)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
