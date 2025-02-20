//
//  FlagChallengeXApp.swift
//  FlagChallengeX
//
//  Created by Yaro4ka on 18.02.2025.
//

import SwiftUI

@main
struct FlagChallengeXApp: App {
    @State private var game = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environment(game)
        }
    }
}
