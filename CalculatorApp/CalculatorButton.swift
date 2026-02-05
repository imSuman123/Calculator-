import SwiftUI

struct CalculatorButton: View {
    let title: String
    let background: Color
    let foreground: Color
    let isWide: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 32, weight: .medium))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(foreground)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
        }
        .frame(width: isWide ? 160 : 72, height: 72)
    }
}

#Preview {
    CalculatorButton(title: "7", background: .gray, foreground: .white, isWide: false) {}
}
