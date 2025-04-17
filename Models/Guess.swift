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
    var cardFlip = [Bool](repeating: false, count: 5)
    var guessLetter: [String] {
        word.map { String($0) }
    }
}
