import SwiftUI

@Observable
final class UserSettingsManager {
    var userSettings = UserSettingsModel()
    
    func updateUserSettings(_ newUserSettings: UserSettingsModel) {
        self.userSettings = newUserSettings
    }
}
