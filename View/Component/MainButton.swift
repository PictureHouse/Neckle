import SwiftUI

// The main button is displayed at the bottom of the screen and informs the user of the AirPods connection status and manages whether or not the neck exercise is in progress.
struct MainButton: View {
    let state: MainButtonState
    let type: AudioDevice
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(state != .disabled ? .teal : .gray)
                    .overlay {
                        if state == .disabled {
                            Image(systemName: type.description)
                                .font(.system(size: 32))
                                .foregroundStyle(.white)
                        } else {
                            Image(systemName: state.rawValue + ".fill")
                                .font(.system(size: 32))
                                .foregroundStyle(.white)
                        }
                    }
            }
            .disabled(state == .disabled)
            .padding(8)
            
            Text(state == .disabled ? state.description + type.rawValue : state.description)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
    }
}

// Enum type containing the state of the main button.
enum MainButtonState: String, CustomStringConvertible {
    // The status of the main button is configured as neck exercise not in progress, neck exercise in progress, and AirPods not connected.
    case play
    case stop
    case disabled
    
    // The string to be displayed on the main button for each step.
    var description: String {
        switch self {
        case .play:
            return "Tap to start exercise"
        case .stop:
            return "Tap to stop exercise"
        case .disabled:
            return "Please wear your "
        }
    }
}

#Preview {
    MainButton(state: .play, type: .AirPods, action: { })
}
