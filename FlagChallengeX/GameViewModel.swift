//
//  GameViewModel.swift
//  FlagChallengeX
//
//  Created by Yaro4ka on 18.02.2025.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var score = 0
    @Published var currentQuestionIndex = 0
    @Published var selectedCountries: [Country] = []
    @Published var correctAnswer: Country?
    @Published var choices: [Country] = []
    
    init() {
        startGame()
    }
    
    func startGame() {
        let allCountries = countries.shuffled()
        selectedCountries = Array(allCountries.prefix(5))
        loadNextQuestion()
        score = 0
    }
    
    func loadNextQuestion() {
        if currentQuestionIndex < selectedCountries.count {
            correctAnswer = selectedCountries[currentQuestionIndex]

            // Get 3 random countries, excluding the correct one
            let options = countries.filter { $0 != correctAnswer }.shuffled().prefix(3)
            
            // Add correct answer and shuffle
            // Shuffle ensures that choices are randomized.
            choices = ([correctAnswer!] + options).shuffled()
        }
    }
    
    func checkAnswer(_ country: Country) {
        if country == correctAnswer {
            score += 1
        }
        currentQuestionIndex += 1
        if currentQuestionIndex < selectedCountries.count {
            loadNextQuestion()
        }
    }
}
