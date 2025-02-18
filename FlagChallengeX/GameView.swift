//
//  GameView.swift
//  FlagChallengeX
//
//  Created by Yaro4ka on 18.02.2025.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var selectedAnswer: Country? = nil
    @State private var isCorrect: Bool? = nil

    var body: some View {
        VStack {
            Text("Flag Challenge X")
                .font(.largeTitle)
                .padding()
            
            if let correctFlag = viewModel.correctAnswer?.flag {
                Text(correctFlag)
                    .font(.system(size: 100))
            }
            
            ForEach(viewModel.choices, id: \.id) { country in
                Button(action: {
                    handleSelection(for: country)
                }) {
                    Text(country.name)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(buttonColor(for: country))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(viewModel.gameOverMode ? 0.5 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: selectedAnswer)
                }
                .padding(.horizontal)
                .disabled(viewModel.gameOverMode || selectedAnswer != nil)
            }
            
            Text("Score: \(viewModel.score)")
                .font(.title)
                .padding()
            
            if viewModel.gameOverMode {
                Button("Restart Game") {
                    resetGame()
                }
                .padding()
            }
        }
        .padding()
    }
    
    private func handleSelection(for country: Country) {
        selectedAnswer = country
        isCorrect = country == viewModel.correctAnswer

        provideHapticFeedback()
        
        // Delay moving to the next question for 0.8 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            viewModel.checkAnswer(country)
            selectedAnswer = nil
            isCorrect = nil
        }
    }
    
    private func provideHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        if isCorrect == true {
            generator.notificationOccurred(.success)
        } else {
            generator.notificationOccurred(.error)
        }
    }
    
    private func buttonColor(for country: Country) -> Color {
        if let selected = selectedAnswer, selected == country {
            return isCorrect == true ? Color.green : Color.red
        }
        return Color.blue
    }
    
    private func resetGame() {
        viewModel.startGame()
        selectedAnswer = nil
        isCorrect = nil
    }
}

#Preview {
    GameView()
}
