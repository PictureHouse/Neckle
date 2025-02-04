import SwiftUI

@Observable
final class UserSettingsManager {
    var userSettings = UserSettingsModel()
    
    var userName: String { userSettings.userName }
    var voice: Voice { userSettings.voice }
    var audioDevice: AudioDevice { userSettings.audioDevice }
    var hapticFeedback: Bool { userSettings.hapticFeedback }
    
    func updateUserSettings(_ newUserSettings: UserSettingsModel) {
        self.userSettings = newUserSettings
    }
}
