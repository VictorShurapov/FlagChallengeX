//
//  GameView.swift
//  FlagChallengeX
//
//  Created by Yaro4ka on 18.02.2025.
//

import SwiftUI

struct GameView: View {
    @Environment(GameViewModel.self) private var viewModel
    @State private var selectedAnswer: Country? = nil

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
                .contentTransition(.numericText(countsDown: true))
                .animation(.default, value: viewModel.score)
            
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

        provideHapticFeedback(for: country)
        
        // Delay moving to the next question for 0.8 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            viewModel.checkAnswer(country)
            selectedAnswer = nil
        }
    }
    
    private func provideHapticFeedback(for selected: Country) {
        let generator = UINotificationFeedbackGenerator()
        if selected == viewModel.correctAnswer {
            generator.notificationOccurred(.success)
        } else {
            generator.notificationOccurred(.error)
        }
    }
    
    private func buttonColor(for country: Country) -> Color {
        guard let selected = selectedAnswer else {
            return .blue
        }
        return (selected == viewModel.correctAnswer) && (selected == country) ? .green
             : (selected == country) ? .red
             : .blue
    }
    
    private func resetGame() {
        viewModel.startGame()
        selectedAnswer = nil
    }
}

#Preview {
    GameView()
}
