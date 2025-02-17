import SwiftUI

struct SettingsView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    
    @State private var userName: String = ""
    @State private var voice: Voice = .Aaron
    @State private var audioDevice: AudioDevice = .AirPods
    @State private var verticalIntensity: Double = 0.5
    @State private var horizontalIntensity: Double = 0.7
    @State private var hapticFeedback: Bool = true
    
    let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    var body: some View {
        VStack(spacing: 0) {
            SettingsTextFieldCell(
                title: "User Name",
                placeholder: "Enter your name",
                text: $userName
            )
            
            SettingsMenuCell(
                title: "Voice",
                selection: $voice
            )
            
            SettingsMenuCell(
                title: "Audio Device",
                selection: $audioDevice
            )
            
            SettingsSliderCell(
                title: "Vertical Intensity",
                minValue: 0.3,
                maxValue: 0.8,
                status: $verticalIntensity
            )
            
            SettingsSliderCell(
                title: "Horizontal Intensitys",
                minValue: 0.3,
                maxValue: 0.8,
                status: $horizontalIntensity
            )
            
            SettingsToggleCell(
                title: "Haptic Feedback",
                status: $hapticFeedback
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
        .onAppear {
            userName = userSettingsManager.userName
            voice = userSettingsManager.voice
            audioDevice = userSettingsManager.audioDevice
            verticalIntensity = userSettingsManager.verticalIntensity
            horizontalIntensity = userSettingsManager.horizontalIntensity
            hapticFeedback = userSettingsManager.hapticFeedback
        }
        .onDisappear {
            userSettingsManager.updateUserSettings(
                UserSettingsModel(
                    userName: userName,
                    voice: voice,
                    audioDevice: audioDevice,
                    verticalIntensity: verticalIntensity,
                    horizontalIntensity: horizontalIntensity,
                    hapticFeedback: hapticFeedback
                )
            )
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(UserSettingsManager())
    }
}
