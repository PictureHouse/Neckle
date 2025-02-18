import SwiftUI

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
                        .multilineTextAlignment(.leading)
                    
                    Image("neck_pain")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("A little neck exercise can go a long way in maintaining a healthy neck.")
                        .multilineTextAlignment(.leading)
                    
                    Image("neck_exercise")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("That’s why I developed Neckle to help users maintain a healthy neck through simple neck exercises.")
                        .multilineTextAlignment(.leading)
                    
                    Image("neck_healthy")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("The name of the app, Neckle, is a combination of the words Neck and Circle, and is intended to help users protect their neck health by filling in the circle.")
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("2025 Yune Cho")
                        
                        Spacer()
                        
                        Text("Images from iStock by Getty Images")
                    }
                    .font(.caption2)
                    .foregroundStyle(.gray)
                }
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
