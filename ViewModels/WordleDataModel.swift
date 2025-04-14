//
//  WordleDataModel.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    
    init(){
        newGame()
    }
    
    func newGame(){
        populatedDefaults()
    }
    
    func populatedDefaults(){
        guesses = []
        for index in 0...5{
            guesses.append(Guess(index: index))
        }
    }
}
