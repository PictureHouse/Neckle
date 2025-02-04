import SwiftUI

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

enum MainButtonState: String, CustomStringConvertible {
    case play
    case stop
    case disabled
    
    var description: String {
        switch self {
        case .play:
            return "Tap to start stretching"
        case .stop:
            return "Tap to stop stretching"
        case .disabled:
            return "Please wear your "
        }
    }
}

#Preview {
    MainButton(state: .play, type: .AirPods, action: { })
}
