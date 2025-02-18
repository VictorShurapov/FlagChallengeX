//
//  GameView.swift
//  FlagChallengeX
//
//  Created by Yaro4ka on 18.02.2025.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()

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
                    viewModel.checkAnswer(country)
                }) {
                    Text(country.name)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(viewModel.gameOverMode ? 0.5 : 1.0)
                }
                .padding(.horizontal)
                .disabled(viewModel.gameOverMode)
            }
            
            Text("Score: \(viewModel.score)")
                .font(.title)
                .padding()
            
            if viewModel.gameOverMode {
                Button("Restart Game") {
                    viewModel.startGame()
                }
                .padding()
            }
        }
        .padding()
    }
}


#Preview {
    GameView()
}
