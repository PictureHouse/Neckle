import SwiftUI

// Settings view where users can change their user settings.
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
            .sensoryFeedback(.impact, trigger: hapticFeedback ? voice : nil)
            
            SettingsMenuCell(
                title: "Audio Device",
                selection: $audioDevice
            )
            .sensoryFeedback(.impact, trigger: hapticFeedback ? audioDevice : nil)
            
            // Haptic feedback is only supported on iPhone, so the haptic feedback settings are only visible on iPhone.
            if UIDevice.current.userInterfaceIdiom == .phone {
                SettingsToggleCell(
                    title: "Haptic Feedback",
                    status: $hapticFeedback
                )
            }
            
            SettingsSliderCell(
                title: "Vertical Intensity",
                minValue: 0.3,
                maxValue: 0.8,
                status: $verticalIntensity
            )
            .sensoryFeedback(.increase, trigger: hapticFeedback ? verticalIntensity : nil)
            
            SettingsSliderCell(
                title: "Horizontal Intensity",
                minValue: 0.3,
                maxValue: 0.8,
                status: $horizontalIntensity
            )
            .sensoryFeedback(.increase, trigger: hapticFeedback ? horizontalIntensity : nil)
            
            Text("You can choose the voice type and audio device you want and adjust the intensity according to the condition of your neck.")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
            
            Spacer()
            
            Text("version \(version)")
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    voice = .Aaron
                    audioDevice = .AirPods
                    verticalIntensity = 0.5
                    horizontalIntensity = 0.7
                    hapticFeedback = true
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(.teal)
                }
            }
        }
        .onAppear {
            // Loads user settings data when the settings screen appears.
            voice = userSettingsManager.voice
            audioDevice = userSettingsManager.audioDevice
            verticalIntensity = userSettingsManager.verticalIntensity
            horizontalIntensity = userSettingsManager.horizontalIntensity
            hapticFeedback = userSettingsManager.hapticFeedback
        }
        .onDisappear {
            // Automatically updates the user's settings data when exiting the settings screen.
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
