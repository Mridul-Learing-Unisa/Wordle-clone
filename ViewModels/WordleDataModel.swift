//
//  WordleDataModel.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    
    var keyColors = [String: Color]()
    
    init(){
        newGame()
    }
    
    //MARK: - Setup
    func newGame(){
        populatedDefaults()
    }
    
    func populatedDefaults(){
        guesses = []
        for index in 0...5{
            guesses.append(Guess(index: index))
        }
        let letters = "ABCDEFGHIJKLMNOPQERSTUVWXYZ"
        for char in letters{
            keyColors[String(char)] = .Unused
        }
    }
    //MARK: - Game Play
    func addToCurrentWord(_ letter: String){
        
    }
    
    func enterWord(){
        
    }
    func removeLetterFromCurrentWord(){
        
    }
}
