//
//  GameViewModel.swift
//  FlagChallengeX
//
//  Created by Yaro4ka on 18.02.2025.
//

import Foundation

@Observable class GameViewModel {
    var score = 0
    var currentQuestionIndex = 0
    var selectedCountries: [Country] = []
    var correctAnswer: Country?
    var choices: [Country] = []
    var gameOverMode: Bool = false
    private(set) var countriesCount = 5
    
    init() {
        startGame()
    }
    
    func startGame() {
        currentQuestionIndex = 0
        gameOverMode = false
        let allCountries = countries.shuffled()
        selectedCountries = Array(allCountries.prefix(countriesCount))
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
        } else {
            gameOverMode = true
        }
    }
}
