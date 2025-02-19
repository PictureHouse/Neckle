import SwiftUI
import Observation
import AVFoundation

// Manager that performs TTS, which reads text aloud.
@Observable
final class SpeechManager {
    private let synthesizer = AVSpeechSynthesizer()
    
    // A function that performs TTS by receiving the text to be spoken and the set voice as parameters.
    func speak(text: String, voice: Voice) {
        let utterance = AVSpeechUtterance(string: text)
        if let voice = AVSpeechSynthesisVoice(identifier: voice.description) {
            utterance.voice = voice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        }
        utterance.rate = 0.4
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        synthesizer.speak(utterance)
    }
    
    // A function that immediately stops TTS.
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
