//
//  Stastic.swift
//  Wordle
//
//  Created by mri on 18/4/2025.
//

import Foundation

struct Stastic: Codable {
    var frequencies = [Int](repeating: 0, count: 6)
    var games = 0
    var streak = 0
    var maxStreak = 0
    
    var wins: Int {
        frequencies.reduce(0, +)
    }
    
    func saveStat(){
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Stat")
        }
    }
    static func loadStat() -> Stastic? {
        if let saveStat = UserDefaults.standard.object(forKey: "Stat") as? Data{
            if let currentStat = try? JSONDecoder().decode(Stastic.self, from: saveStat) {
                return currentStat
            }else {
                return Stastic()
            }
        } else {
            return Stastic()
        }
    }
    
    mutating func update(win: Bool, index: Int? = nil){
        games += 1
        streak = win ? streak + 1 : 0
        if win{
            frequencies[index!] += 1
            maxStreak = max(maxStreak, streak)
        }
        saveStat()
    }
    
}
