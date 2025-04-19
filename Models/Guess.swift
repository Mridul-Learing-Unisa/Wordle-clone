//
//  Guess.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import SwiftUI

struct Guess {
    let index: Int
    var word: String = "     "
    var bgColors = [Color](repeating: .Wrong, count: 5)
    var cardFlipped = [Bool](repeating: false, count: 5)
    var guessLetter: [String] {
        word.map { String($0) }
    }
    
    //
    // 🟨🟩🟩🟩⬛
    var results: String {
        let tryColors: [Color : String] = [.Misplaced : "🟨", .Correct : "🟩", .Wrong : "⬛"]
        return bgColors.compactMap {tryColors[$0]}.joined(separator: "")
        }
}
