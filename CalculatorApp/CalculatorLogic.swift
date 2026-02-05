import Foundation

enum CalculatorOperation: String {
    case add = "+"
    case subtract = "−"
    case multiply = "×"
    case divide = "÷"
    case none
}

struct CalculatorState {
    var display: String = "0"
    var previousValue: Double? = nil
    var pendingOperation: CalculatorOperation = .none
    var shouldResetDisplay = false

    mutating func inputDigit(_ digit: String) {
        if shouldResetDisplay {
            display = digit
            shouldResetDisplay = false
            return
        }

        if display == "0" && digit != "." {
            display = digit
        } else if digit == "." && display.contains(".") {
            return
        } else {
            display += digit
        }
    }

    mutating func toggleSign() {
        guard let value = Double(display) else { return }
        let newValue = value * -1
        display = format(value: newValue)
    }

    mutating func percent() {
        guard let value = Double(display) else { return }
        display = format(value: value / 100)
    }

    mutating func clear() {
        display = "0"
        previousValue = nil
        pendingOperation = .none
        shouldResetDisplay = false
    }

    mutating func setOperation(_ operation: CalculatorOperation) {
        guard let value = Double(display) else { return }
        if let previous = previousValue, pendingOperation != .none, !shouldResetDisplay {
            let result = performOperation(previous: previous, current: value, operation: pendingOperation)
            display = format(value: result)
            previousValue = result
        } else {
            previousValue = value
        }
        pendingOperation = operation
        shouldResetDisplay = true
    }

    mutating func equals() {
        guard let previous = previousValue, let current = Double(display) else { return }
        let result = performOperation(previous: previous, current: current, operation: pendingOperation)
        display = format(value: result)
        previousValue = nil
        pendingOperation = .none
        shouldResetDisplay = true
    }

    private func performOperation(previous: Double, current: Double, operation: CalculatorOperation) -> Double {
        switch operation {
        case .add:
            return previous + current
        case .subtract:
            return previous - current
        case .multiply:
            return previous * current
        case .divide:
            return current == 0 ? 0 : previous / current
        case .none:
            return current
        }
    }

    private func format(value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        }
        return String(format: "%.6f", value).replacingOccurrences(of: "0+$", with: "", options: .regularExpression)
    }
}
