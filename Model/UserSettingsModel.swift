import SwiftUI

final class UserSettingsModel {
    @AppStorage("userName") var userName: String = ""
    @AppStorage("voice") var voice: Voice = .Aaron
    @AppStorage("audioDevice") var audioDevice: AudioDevice = .AirPods
    @AppStorage("hapticFeedback") var hapticFeedback: Bool = true
}

enum Voice: String, CaseIterable, Identifiable {
    case Aaron
    case Fred
    case Nicky
    case Samantha
    
    var id: Self { self }
}

enum AudioDevice: String, CustomStringConvertible, CaseIterable, Identifiable {
    case AirPods
    case AirPods3
    case AirPodsPro
    case AirPodsMax
    case Headphones
    
    var id: Self { self }
    
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
