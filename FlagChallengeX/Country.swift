//
//  Country.swift
//  FlagChallengeX
//
//  Created by Yaro4ka on 18.02.2025.
//

import Foundation

struct Country: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let flag: String

    // Implement Equatable to compare two Country objects
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name && lhs.flag == rhs.flag
    }
}

let countries = [
    Country(name: "Ukraine", flag: "🇺🇦"),
    Country(name: "Germany", flag: "🇩🇪"),
    Country(name: "United Kingdom", flag: "🇬🇧"),
    Country(name: "Japan", flag: "🇯🇵"),
    Country(name: "Netherlands", flag: "🇳🇱"),
    Country(name: "Brazil", flag: "🇧🇷"),
    Country(name: "Nigeria", flag: "🇳🇬"),
    Country(name: "Italy", flag: "🇮🇹"),
    Country(name: "UAE", flag: "🇦🇪")
]
