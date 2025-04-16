//
//  WordleDataModel.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    @Published var incorrectAtempts = [Int](repeating: 0, count: 6)
    
    var keyColors = [String: Color]()
    var selectedWord = ""
    var currentWord = ""
    var tryIndex = 0
    var inPlay = false
    
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    var disabledKeyboard: Bool {
        !inPlay || currentWord.count == 5
    }
    
    init(){
        newGame()
    }
    
    //MARK: - Setup
    func newGame(){
        populatedDefaults()
        selectedWord = Global.commanWords.randomElement()!
        currentWord = ""
        inPlay = true
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
        currentWord += letter
        updateRow()
    }
    
    func enterWord(){
        
        if verifyWord(){
            print("Valid Word")
        } else {
            withAnimation {
                self.incorrectAtempts[tryIndex] += 1
            }
            incorrectAtempts[tryIndex] = 0
        }
    }
    func removeLetterFromCurrentWord(){
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow(){
        
        let guessword = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessword
    }
    
    func verifyWord() -> Bool{
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
}
