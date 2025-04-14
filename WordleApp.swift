//
//  WordleApp.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import SwiftUI

@main
struct WordleApp: App {
    @StateObject var dm = WordleDataModel()
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dm)
        }
    }
}
