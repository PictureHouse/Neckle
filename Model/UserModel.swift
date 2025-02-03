import SwiftData

@Model
final class UserModel {
    var userName: String
    var voice: String
    var audioDevice: String
    var hapticFeedback: Bool
    
    init(userName: String, voice: Voice, audioDevice: AudioDevice, hapticFeedback: Bool) {
        self.userName = userName
        self.voice = voice.rawValue
        self.audioDevice = audioDevice.rawValue
        self.hapticFeedback = hapticFeedback
    }
}

enum Voice: String {
    case Aaron
    case Fred
    case Nicky
    case Samantha
}

enum AudioDevice: String, CustomStringConvertible {
    case AirPods
    case AirPods3
    case AirPodsPro
    case AirPodsMax
    case Headphones
    
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
        case .Headphones:
            return "headphones"
        }
    }
}
