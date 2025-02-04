import SwiftUI

struct SettingsMenuCell<T: CaseIterable & Identifiable & RawRepresentable & Hashable>: View where T.RawValue == String {
    let title: String
    let image: String
    @Binding var selection: T
    
    var body: some View {
        VStack {
            HStack {
                Label(title, systemImage: image)
                    .bold()
                
                Spacer()
                
                Picker("test", selection: $selection) {
                    ForEach(Array(T.allCases), id: \.self) { enumCase in
                        Text(enumCase.rawValue).tag(enumCase)
                    }
                }
            }
            
            Divider()
        }
    }
}

#Preview {
    SettingsMenuCell<Voice>(
        title: "Title",
        image: "person.fill",
        selection: .constant(Voice.Aaron)
    )
}
