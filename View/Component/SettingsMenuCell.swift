import SwiftUI

struct SettingsMenuCell<T: CaseIterable & Identifiable & RawRepresentable & Hashable>: View where T.RawValue == String {
    let title: String
    @Binding var selection: T
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .bold()
                
                Spacer()
                
                Picker(selection.rawValue, selection: $selection) {
                    ForEach(Array(T.allCases), id: \.self) { enumCase in
                        Text(enumCase.rawValue).tag(enumCase)
                    }
                }
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
