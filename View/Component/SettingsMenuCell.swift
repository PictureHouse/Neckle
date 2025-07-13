import SwiftUI

// A component of the settings screen that change settings value using a picker.
struct SettingsMenuCell<T: CaseIterable & Identifiable & RawRepresentable & Hashable>: View where T.RawValue == String {
    let title: String
    @Binding var selection: T
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                
                Spacer()
                
                Picker(title, selection: $selection) {
                    ForEach(Array(T.allCases), id: \.self) { enumCase in
                        Text(enumCase.rawValue)
                            .font(.system(size: 16))
                            .tag(enumCase)
                    }
                }
                .pickerStyle(.menu)
            }
            .padding(.bottom, 8)
            
            Divider()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SettingsMenuCell<Voice>(
        title: "Title",
        selection: .constant(Voice.Aaron)
    )
}
