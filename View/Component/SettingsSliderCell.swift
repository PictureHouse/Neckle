import SwiftUI

// A component of the settings screen that change settings value using a slider.
struct SettingsSliderCell: View {
    let title: String
    let minValue: Double
    let maxValue: Double
    @Binding var status: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
            
            Slider(value: $status, in: minValue...maxValue) {
            } minimumValueLabel: {
                Text("Min")
                    .font(.system(size: 12))
            } maximumValueLabel: {
                Text("Max")
                    .font(.system(size: 12))
            }
            .tint(.teal)
            .padding(.bottom, 8)
            
            Divider()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    @Previewable @State var status: Double = 0.5
    
    SettingsSliderCell(
        title: "title",
        minValue: 0.3,
        maxValue: 0.8,
        status: $status
    )
}
