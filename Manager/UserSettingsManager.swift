import SwiftUI
import Observation

// Manager that manages user settings information.
@Observable
final class UserSettingsManager {
    // A model object that contains the user's settings information.
    var userSettings = UserSettingsModel()
    
    // Properties that return each item in the user's settings.
    var voice: Voice { userSettings.voice }
    var audioDevice: AudioDevice { userSettings.audioDevice }
    var verticalIntensity: Double { userSettings.verticalIntensity }
    var horizontalIntensity: Double { userSettings.horizontalIntensity }
    var hapticFeedback: Bool { userSettings.hapticFeedback }
    
    // A function that updates the user's settings.
    func updateUserSettings(_ newUserSettings: UserSettingsModel) {
        self.userSettings = newUserSettings
    }
    
    // A function that sends feedback email to develpoer.
    func sendFeedback(openURL: OpenURLAction) {
        let feedbackEmail = FeedbackEmail()
        let urlString = "mailto:\(feedbackEmail.email)?subject=\(feedbackEmail.subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(feedbackEmail.body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        
        guard let url = URL(string: urlString) else { return }
        openURL.callAsFunction(url)
    }
}
