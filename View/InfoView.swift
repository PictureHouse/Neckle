import SwiftUI

// Information view containing information such as the app's background and purpose.
struct InfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            header
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("About Neckle")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.teal)
                    
                    Text("Neck pain is one of the most common pains among modern people who use mobile phones and computers a lot. It is a chronic disease that makes our daily lives uncomfortable.")
                    
                    Image("neck_pain")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Even simple neck exercises you do in your daily life can go a long way in maintaining a healthy neck.")
                    
                    Image("neck_exercise")
                        .resizable()
                        .scaledToFit()
                    
                    Text("That’s why I developed Neckle to help users maintain a healthy neck through simple neck exercises.")
                    
                    Image("neck_healthy")
                        .resizable()
                        .scaledToFit()
                    
                    Text("The name of the app, Neckle, is a combination of the words Neck and Circle, and is intended to help users protect their neck health by filling in the circle.")
                    
                    Image("airpods")
                        .resizable()
                        .scaledToFit()
                    
                    Text("This app uses the motion sensor in AirPods to measure head movement and helps users exercise their neck with voice guidance through AirPods. Put on your AirPods and enjoy Neckle!")
                }
                .multilineTextAlignment(.leading)
                .font(.system(size: 16))
            }
            .frame(minWidth: 300, maxWidth: 500)
            .scrollIndicators(.hidden)
        }
        .padding(16)
        .background(.black.opacity(0.95))
        .foregroundStyle(.white)
    }
}

private extension InfoView {
    // Header of the information view.
    var header: some View {
        HStack(spacing: 16) {
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.teal)
            }
        }
    }
}

#Preview {
    InfoView()
}
