import SwiftUI

// A component of the settings screen that change settings value using a picker.
struct SettingsMenuCell<T: CaseIterable & Identifiable & RawRepresentable & Hashable>: View where T.RawValue == String {
    let title: String
    @Binding var selection: T
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
            
            Spacer()
            
            Picker("", selection: $selection) {
                ForEach(Array(T.allCases), id: \.self) { enumCase in
                    Text(enumCase.rawValue)
                        .font(.system(size: 16))
                        .tag(enumCase)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    SettingsMenuCell<Voice>(
        title: "Title",
        selection: .constant(Voice.Aaron)
    )
}
