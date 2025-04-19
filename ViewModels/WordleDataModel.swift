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
    @Published var toastText: String?
    @Published var showStats = false
    
    var keyColors = [String: Color]()
    var matchedLetters = [String]()
    var misplacedLetters = [String]()
    var selectedWord = ""
    var currentWord = ""
    var tryIndex = 0
    var inPlay = false
    var gameOver = false
    var toastWords = ["Genius", "Magnificent", "Impressive", "Splendid", "Great", "Phew"]
    var currentStat: Stastic
    
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    var disabledKeyboard: Bool {
        !inPlay || currentWord.count == 5
    }
    
    init(){
        currentStat = Stastic()
        newGame()
    }
    
    //MARK: - Setup
    func newGame(){
        populatedDefaults()
        selectedWord = Global.commanWords.randomElement()!
        currentWord = ""
        inPlay = true
        tryIndex = 0
        gameOver = false
        print(selectedWord)
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
        matchedLetters = []
        misplacedLetters = []
    }
    //MARK: - Game Play
    func addToCurrentWord(_ letter: String){
        currentWord += letter
        updateRow()
    }
    
    func enterWord(){
        if currentWord == selectedWord{
            gameOver = true
            print("You Win")
            setCurrentGuessColors()
            currentStat.update(win: true, index: tryIndex)
            showToast(with: toastWords[tryIndex])
            inPlay = false
        }
        else{
            
            if verifyWord(){
                print("Valid Word")
                setCurrentGuessColors()
                tryIndex += 1
                currentWord = ""
                if tryIndex == 6 {
                    currentStat.update(win: false, index: tryIndex)
                    gameOver = true
                    inPlay = false
                    showToast(with: selectedWord)
                }
            } else {
                withAnimation {
                    self.incorrectAtempts[tryIndex] += 1
                }
                showToast(with: "Not in word list.")
                incorrectAtempts[tryIndex] = 0
            }
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
    
    func setCurrentGuessColors(){
        let correctLetters = selectedWord.map{String($0)}
        var frequency = [String: Int]()
        
        for letters in correctLetters{
            frequency[letters, default: 0] += 1
        }
        
        for index in 0...4 {
            let correctLetter = correctLetters[index]
            let guessLetter = guesses[tryIndex].guessLetter[index]
            if correctLetter == guessLetter{
                guesses[tryIndex].bgColors[index] = .Correct
                if !matchedLetters.contains(guessLetter){
                    matchedLetters.append(guessLetter)
                    keyColors[guessLetter] = .Correct
                }
                if misplacedLetters.contains(guessLetter){
                    if let index = misplacedLetters.firstIndex(where: {$0 == guessLetter}){
                        misplacedLetters.remove(at: index)
                    }
                }
                frequency[guessLetter]! -= 1
            }
        }
        for index in 0...4 {
            let guessLetter = guesses[tryIndex].guessLetter[index]
            if correctLetters.contains(guessLetter) && guesses[tryIndex].bgColors[index] != .Correct && frequency[guessLetter]! > 0{
                guesses[tryIndex].bgColors[index] = .Misplaced
                if !misplacedLetters.contains(guessLetter) && !matchedLetters.contains(guessLetter){
                    misplacedLetters.append(guessLetter)
                    keyColors[guessLetter] = .Misplaced
                }
                frequency[guessLetter]! -= 1
            }
        }
        for index in 0...4 {
            let guessLetter = guesses[tryIndex].guessLetter[index]
            if keyColors[guessLetter] != .Correct && keyColors[guessLetter] != .Misplaced{
                keyColors[guessLetter] = .Wrong
            }
        }
        flipCard(for: tryIndex)
    }
    func flipCard(for row: Int){
        for column in 0...4{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(column)*0.2){
                self.guesses[row].cardFlipped[column].toggle()
            }
        }
    }
    
    func showToast(with text: String){
        withAnimation{
            toastText = text
        }
        withAnimation(Animation.linear(duration: 0.2).delay(3)){
            toastText = nil
            if gameOver{
                withAnimation(Animation.linear(duration: 0.2).delay(3)){
                    showStats.toggle()
                }
            }
        }
    }
    
    func sharedResult(){
        let stat = Stastic.loadStat()
        let resultString = """
            Wordle \(stat!.games) \(tryIndex < 6 ? "\(tryIndex + 1)/6": "")
            \(guesses.compactMap{$0.results}.joined(separator: "\n"))
            """
        
        let activityController = UIActivityViewController(activityItems: [resultString], applicationActivities: nil)
        switch UIDevice.current.userInterfaceIdiom {
        case.phone:
            UIWindow.key?.rootViewController!
                .present(activityController, animated: true)
        case .pad:
            activityController.popoverPresentationController?.sourceView = UIWindow.key
            activityController.popoverPresentationController?.sourceRect = CGRect(x: Global.screenWidth / 2,
                                                                                  y: Global.screenWidth / 2,
                                                                                  width: 200,
                                                                                  height: 200)
            UIWindow.key?.rootViewController!.present(activityController, animated: true)
        default :
            break
        }
    }
}
