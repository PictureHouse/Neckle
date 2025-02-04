import SwiftUI

struct SettingsView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    
    let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    var body: some View {
        VStack(spacing: 0) {
            SettingsTextFieldCell(
                title: "User Name",
                placeholder: "Enter your name",
                text: userSettingsManager.userSettings.$userName
            )
            
            SettingsMenuCell(
                title: "Voice",
                selection: userSettingsManager.userSettings.$voice
            )
            
            SettingsMenuCell(
                title: "Audio Device",
                selection: userSettingsManager.userSettings.$audioDevice
            )
            
            SettingsToggleCell(
                title: "Haptic Feedback",
                status: userSettingsManager.userSettings.$hapticFeedback
            )
            
            Spacer()
            
            Text("version \(version)")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
        .padding(16)
        .foregroundStyle(.white)
        .background(.black.opacity(0.95))
        .ignoresSafeArea(.keyboard)
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
            .environment(UserSettingsManager())
    }
}
