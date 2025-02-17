import SwiftUI

struct SettingsView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    
    @State private var voice: Voice = .Aaron
    @State private var audioDevice: AudioDevice = .AirPods
    @State private var verticalIntensity: Double = 0.5
    @State private var horizontalIntensity: Double = 0.7
    @State private var hapticFeedback: Bool = true
    
    let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    var body: some View {
        VStack(spacing: 0) {
            SettingsMenuCell(
                title: "Voice",
                selection: $voice
            )
            
            SettingsMenuCell(
                title: "Audio Device",
                selection: $audioDevice
            )
            
            SettingsToggleCell(
                title: "Haptic Feedback",
                status: $hapticFeedback
            )
            
            SettingsSliderCell(
                title: "Vertical Intensity",
                minValue: 0.3,
                maxValue: 0.8,
                status: $verticalIntensity
            )
            
            SettingsSliderCell(
                title: "Horizontal Intensity",
                minValue: 0.3,
                maxValue: 0.8,
                status: $horizontalIntensity
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
            voice = userSettingsManager.voice
            audioDevice = userSettingsManager.audioDevice
            verticalIntensity = userSettingsManager.verticalIntensity
            horizontalIntensity = userSettingsManager.horizontalIntensity
            hapticFeedback = userSettingsManager.hapticFeedback
        }
        .onDisappear {
            userSettingsManager.updateUserSettings(
                UserSettingsModel(
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
