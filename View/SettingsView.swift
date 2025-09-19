import SwiftUI

// Settings view where users can change their user settings.
struct SettingsView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @Environment(\.openURL) private var openURL
    
    @State private var voice: Voice = .Aaron
    @State private var audioDevice: AudioDevice = .AirPods
    @State private var hapticFeedback: Bool = true
    @State private var intesitySettingsExpanded: Bool = false
    @State private var pitchIntensity: Double = 0.5
    @State private var yawIntensity: Double = 0.6
    @State private var rollIntensity: Double = 0.4
    @State private var showResetAlert: Bool = false
    
    let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
            
            DisclosureGroup(isExpanded: $intesitySettingsExpanded) {
                HStack {
                    Text("You can adjust the intensity according to the condition of your neck.")
                        .font(.system(size: 10))
                        .foregroundStyle(.white.opacity(0.5))
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 8)
                    
                    Spacer()
                }
                
                SettingsSliderCell(
                    title: "Up/Down Intensity",
                    minValue: 0.3,
                    maxValue: 0.8,
                    status: $pitchIntensity
                )
                .sensoryFeedback(.increase, trigger: hapticFeedback ? pitchIntensity : nil)
                
                SettingsSliderCell(
                    title: "Left/Right Intensity",
                    minValue: 0.3,
                    maxValue: 0.8,
                    status: $yawIntensity
                )
                .sensoryFeedback(.increase, trigger: hapticFeedback ? yawIntensity : nil)
                
                SettingsSliderCell(
                    title: "Head Tilt Intensity",
                    minValue: 0.3,
                    maxValue: 0.8,
                    status: $rollIntensity
                )
                .sensoryFeedback(.increase, trigger: hapticFeedback ? rollIntensity : nil)
            } label: {
                Text("Intensity Customization")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.vertical, 8)
            }
            
            Spacer()
            
            footer
        }
        .padding(16)
        .foregroundStyle(.white)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.teal)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showResetAlert = true
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 16))
                        .foregroundStyle(.teal)
                }
            }
        }
        .onAppear {
            // Loads user settings data when the settings screen appears.
            voice = userSettingsManager.voice
            audioDevice = userSettingsManager.audioDevice
            pitchIntensity = userSettingsManager.pitchIntensity
            yawIntensity = userSettingsManager.yawIntensity
            rollIntensity = userSettingsManager.rollIntensity
            hapticFeedback = userSettingsManager.hapticFeedback
        }
        .onDisappear {
            // Automatically updates the user's settings data when exiting the settings screen.
            userSettingsManager.updateUserSettings(
                UserSettingsModel(
                    voice: voice,
                    audioDevice: audioDevice,
                    pitchIntensity: pitchIntensity,
                    yawIntensity: yawIntensity,
                    rollIntensity: rollIntensity,
                    hapticFeedback: hapticFeedback
                )
            )
        }
        .alert("Reset settings", isPresented: $showResetAlert) {
            Button(role: .destructive) {
                resetSettings()
            } label: {
                Text("Reset")
                    .font(.system(size: 16, weight: .bold))
            }
        } message: {
            Text("Would you like to reset your settings?")
                .font(.system(size: 16))
        }
    }
}

private extension SettingsView {
    var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Neckle | version \(version)")
                    .font(.system(size: 14))
                
                Text("2025 Yune Cho")
                    .font(.system(size: 10))
            }
            .foregroundStyle(.white.opacity(0.5))
            
            Spacer()
            
            if #available(iOS 26.0, *) {
                Button {
                    userSettingsManager.sendFeedback(openURL: openURL)
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 18))
                        
                        Text("Feedback")
                            .font(.system(size: 10))
                    }
                }
                .frame(width: 64, height: 64)
                .glassEffect(.clear)
            } else {
                Button {
                    userSettingsManager.sendFeedback(openURL: openURL)
                } label: {
                    Circle()
                        .fill(Color.teal)
                        .frame(width: 64, height: 64)
                        .overlay {
                            VStack(spacing: 4) {
                                Image(systemName: "envelope.fill")
                                    .font(.system(size: 18))
                                
                                Text("Feedback")
                                    .font(.system(size: 10))
                            }
                        }
                }
            }
        }
    }
}

private extension SettingsView {
    func resetSettings() {
        voice = .Aaron
        audioDevice = .AirPods
        pitchIntensity = 0.5
        yawIntensity = 0.6
        rollIntensity = 0.4
        hapticFeedback = true
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(UserSettingsManager())
    }
}
