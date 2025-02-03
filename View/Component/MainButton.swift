import SwiftUI

struct MainButton: View {
    let state: MainButtonState
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
                            Image(systemName: "airpods.pro")
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
            
            Text(state.description)
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
            return "Please wear your AirPods"
        }
    }
}

#Preview {
    MainButton(state: .play, action: { })
}
