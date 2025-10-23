//
//  ContentView.swift
//  Cursorproject
//
//  Created by 35 GO Participant on 10/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var firstNumber: Double = 0
    @State private var secondNumber: Double = 0
    @State private var operation: String = ""
    @State private var isNewNumber = true
    
    var body: some View {
        VStack(spacing: 20) {
            // Display
            HStack {
                Spacer()
                Text(display)
                    .font(.system(size: 48, weight: .light))
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
            }
            .frame(height: 100)
            .background(Color.black)
            
            // Button Grid
            VStack(spacing: 15) {
                // Row 1: Clear, +/-, %, ÷
                HStack(spacing: 15) {
                    CalculatorButton(title: "C", color: .gray, action: clear)
                    CalculatorButton(title: "±", color: .gray, action: toggleSign)
                    CalculatorButton(title: "%", color: .gray, action: percentage)
                    CalculatorButton(title: "÷", color: .orange, action: { setOperation("÷") })
                }
                
                // Row 2: 7, 8, 9, ×
                HStack(spacing: 15) {
                    CalculatorButton(title: "7", color: .darkGray, action: { inputNumber("7") })
                    CalculatorButton(title: "8", color: .darkGray, action: { inputNumber("8") })
                    CalculatorButton(title: "9", color: .darkGray, action: { inputNumber("9") })
                    CalculatorButton(title: "×", color: .orange, action: { setOperation("×") })
                }
                
                // Row 3: 4, 5, 6, -
                HStack(spacing: 15) {
                    CalculatorButton(title: "4", color: .darkGray, action: { inputNumber("4") })
                    CalculatorButton(title: "5", color: .darkGray, action: { inputNumber("5") })
                    CalculatorButton(title: "6", color: .darkGray, action: { inputNumber("6") })
                    CalculatorButton(title: "-", color: .orange, action: { setOperation("-") })
                }
                
                // Row 4: 1, 2, 3, +
                HStack(spacing: 15) {
                    CalculatorButton(title: "1", color: .darkGray, action: { inputNumber("1") })
                    CalculatorButton(title: "2", color: .darkGray, action: { inputNumber("2") })
                    CalculatorButton(title: "3", color: .darkGray, action: { inputNumber("3") })
                    CalculatorButton(title: "+", color: .orange, action: { setOperation("+") })
                }
                
                // Row 5: 0, ., =
                HStack(spacing: 15) {
                    CalculatorButton(title: "0", color: .darkGray, action: { inputNumber("0") }, isWide: true)
                    CalculatorButton(title: ".", color: .darkGray, action: { inputDecimal() })
                    CalculatorButton(title: "=", color: .orange, action: calculate)
                }
            }
            .padding(.horizontal, 20)
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
    
    // MARK: - Calculator Functions
    
    func inputNumber(_ number: String) {
        if isNewNumber {
            display = number
            isNewNumber = false
        } else {
            if display == "0" {
                display = number
            } else {
                display += number
            }
        }
    }
    
    func inputDecimal() {
        if isNewNumber {
            display = "0."
            isNewNumber = false
        } else if !display.contains(".") {
            display += "."
        }
    }
    
    func setOperation(_ op: String) {
        if !isNewNumber {
            calculate()
        }
        firstNumber = Double(display) ?? 0
        operation = op
        isNewNumber = true
    }
    
    func calculate() {
        if !operation.isEmpty && !isNewNumber {
            secondNumber = Double(display) ?? 0
            
            switch operation {
            case "+":
                firstNumber += secondNumber
            case "-":
                firstNumber -= secondNumber
            case "×":
                firstNumber *= secondNumber
            case "÷":
                if secondNumber != 0 {
                    firstNumber /= secondNumber
                } else {
                    display = "Error"
                    isNewNumber = true
                    operation = ""
                    return
                }
            default:
                break
            }
            
            // Format the result
            if firstNumber == floor(firstNumber) {
                display = String(format: "%.0f", firstNumber)
            } else {
                display = String(firstNumber)
            }
            
            operation = ""
            isNewNumber = true
        }
    }
    
    func clear() {
        display = "0"
        firstNumber = 0
        secondNumber = 0
        operation = ""
        isNewNumber = true
    }
    
    func toggleSign() {
        if let number = Double(display) {
            let newNumber = -number
            if newNumber == floor(newNumber) {
                display = String(format: "%.0f", newNumber)
            } else {
                display = String(newNumber)
            }
        }
    }
    
    func percentage() {
        if let number = Double(display) {
            let percentage = number / 100
            if percentage == floor(percentage) {
                display = String(format: "%.0f", percentage)
            } else {
                display = String(percentage)
            }
        }
    }
}

struct CalculatorButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    var isWide: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.white)
                .frame(width: isWide ? 160 : 70, height: 70)
                .background(color)
                .clipShape(Circle())
        }
    }
}

extension Color {
    static let darkGray = Color(red: 0.2, green: 0.2, blue: 0.2)
}

#Preview {
    ContentView()
}
