import SwiftUI

final class UserSettingsModel {
    @AppStorage("userName") var userName: String = ""
    @AppStorage("voice") var voice: Voice = .Aaron
    @AppStorage("audioDevice") var audioDevice: AudioDevice = .AirPods
    @AppStorage("hapticFeedback") var hapticFeedback: Bool = true
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
