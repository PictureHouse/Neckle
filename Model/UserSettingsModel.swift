import SwiftUI

// Model for managing user settings data.
final class UserSettingsModel {
    // Since AppStorage is used, the saved values ​​will not disappear even if the app is terminated.
    @AppStorage("voice") var voice: Voice = .Aaron
    @AppStorage("audioDevice") var audioDevice: AudioDevice = .AirPods
    @AppStorage("pitch") var pitchIntensity: Double = 0.5
    @AppStorage("yaw") var yawIntensity: Double = 0.6
    @AppStorage("roll") var rollIntensity: Double = 0.6
    @AppStorage("hapticFeedback") var hapticFeedback: Bool = true
    
    init() { }
    
    init(voice: Voice, audioDevice: AudioDevice, pitchIntensity: Double, yawIntensity: Double, rollIntensity: Double, hapticFeedback: Bool) {
        self.voice = voice
        self.audioDevice = audioDevice
        self.pitchIntensity = pitchIntensity
        self.yawIntensity = yawIntensity
        self.rollIntensity = rollIntensity
        self.hapticFeedback = hapticFeedback
    }
}

// Enum type that containing the types of voices.
enum Voice: String, CustomStringConvertible, CaseIterable, Identifiable {
    // There are five voice cases among the voices that support English.
    case Aaron
    case Daniel
    case Fred
    case Nicky
    case Samantha
    
    var id: Self { self }
    
    // A property that contains the identifier of each voice case.
    var description: String {
        switch self {
        case .Aaron:
            return "com.apple.ttsbundle.siri_male_en-US_compact"
        case .Daniel:
            return "com.apple.ttsbundle.Daniel-compact"
        case .Fred:
            return "com.apple.speech.synthesis.voice.Fred"
        case .Nicky:
            return "com.apple.ttsbundle.siri_female_en-US_compact"
        case .Samantha:
            return "com.apple.ttsbundle.Samantha-compact"
        }
    }
}

// Enum type that containing the types of audio devices.
enum AudioDevice: String, CustomStringConvertible, CaseIterable, Identifiable {
    // There are four AirPods as cases for audio devices.
    case AirPods
    case AirPods3
    case AirPodsPro = "AirPods Pro"
    case AirPodsMax = "AirPods Max"
    
    var id: Self { self }
    
    // A property containing the SF Symbol name of each audio device case.
    var description: String {
        switch self {
        case .AirPods:
            return "airpods"
        case .AirPods3:
            return "airpods.gen3"
        case .AirPodsPro:
            return "airpods.pro"
        case .AirPodsMax:
            return "airpods.max"
        }
    }
}

// Struct type for feedback email.
struct FeedbackEmail {
    let email = "picturehouse@kakao.com"
    let subject = "[Neckle Feedback]"
    let body = "Please enter your feedback here.\nThank you."
}
