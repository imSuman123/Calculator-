import SwiftUI

struct ContentView: View {
    @State private var state = CalculatorState()

    private let buttonSpacing: CGFloat = 12

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: buttonSpacing) {
                Spacer()

                HStack {
                    Spacer()
                    Text(state.display)
                        .font(.system(size: 64, weight: .light))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .padding(.horizontal, 24)

                VStack(spacing: buttonSpacing) {
                    buttonRow([
                        .utility("AC"), .utility("±"), .utility("%"), .operation("÷")
                    ])
                    buttonRow([
                        .number("7"), .number("8"), .number("9"), .operation("×")
                    ])
                    buttonRow([
                        .number("4"), .number("5"), .number("6"), .operation("−")
                    ])
                    buttonRow([
                        .number("1"), .number("2"), .number("3"), .operation("+")
                    ])
                    buttonRow([
                        .number("0"), .number("."), .operation("=")
                    ])
                }
            }
            .padding(.bottom, 24)
        }
    }

    private func buttonRow(_ items: [CalculatorButtonType]) -> some View {
        HStack(spacing: buttonSpacing) {
            ForEach(items) { item in
                makeButton(for: item)
            }
        }
    }

    private func makeButton(for item: CalculatorButtonType) -> some View {
        CalculatorButton(
            title: item.title,
            background: item.background,
            foreground: item.foreground,
            isWide: item.isWide
        ) {
            handleTap(item)
        }
    }

    private func handleTap(_ item: CalculatorButtonType) {
        switch item {
        case .number(let value):
            state.inputDigit(value)
        case .utility(let value):
            switch value {
            case "AC":
                state.clear()
            case "±":
                state.toggleSign()
            case "%":
                state.percent()
            default:
                break
            }
        case .operation(let value):
            switch value {
            case "+":
                state.setOperation(.add)
            case "−":
                state.setOperation(.subtract)
            case "×":
                state.setOperation(.multiply)
            case "÷":
                state.setOperation(.divide)
            case "=":
                state.equals()
            default:
                break
            }
        }
    }
}

struct CalculatorButtonType: Identifiable {
    let id = UUID()
    let title: String
    let background: Color
    let foreground: Color
    let isWide: Bool

    static func number(_ value: String) -> CalculatorButtonType {
        CalculatorButtonType(title: value, background: Color(.darkGray), foreground: .white, isWide: value == "0")
    }

    static func utility(_ value: String) -> CalculatorButtonType {
        CalculatorButtonType(title: value, background: Color(.lightGray), foreground: .black, isWide: false)
    }

    static func operation(_ value: String) -> CalculatorButtonType {
        CalculatorButtonType(title: value, background: .orange, foreground: .white, isWide: false)
    }
}

#Preview {
    ContentView()
}
