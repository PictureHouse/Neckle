import SwiftUI

struct HomeView: View {
    @State private var circleStroke: Double = 10
    @State private var scale: CGFloat = 0.8
    @State private var showInfoView: Bool = false
    
    var body: some View {
        Circle()
            .stroke(.teal, lineWidth: circleStroke)
            .frame(width: 350, height: 350)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.linear(duration: 0.7)) {
                    scale = 1
                }
                withAnimation(.linear.repeatForever(autoreverses: true).speed(0.4)) {
                    circleStroke = 20
                }
            }
            .overlay {
                VStack(spacing: 16) {
                    Text("Neckle")
                        .font(.system(size: 60, weight: .bold))
                    
                    Button {
                        showInfoView = true
                    } label: {
                        HStack(spacing: 4) {
                            Text("Keep your neck healthy with Neckle")
                            
                            Image(systemName: "info.circle")
                        }
                        .font(.system(size: 14))
                    }
                }
                .foregroundStyle(.teal)
            }
            .sheet(isPresented: $showInfoView) {
                InfoView()
                    .presentationDragIndicator(.visible)
            }
    }
}

#Preview {
    HomeView()
}
