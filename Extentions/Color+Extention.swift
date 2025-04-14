//
//  Color+Extention.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import SwiftUI

extension Color {
    static var Wrong: Color {
        Color(UIColor(named: "wrong")!)
    }
    static var Misplaced: Color {
        Color(UIColor(named: "misplaced")!)
    }
    static var Correct: Color {
        Color(UIColor(named: "correct")!)
    }
    static var Unused: Color {
        Color(UIColor(named: "unused")!)
    }
    static var systemBackground: Color {
        Color(.systemBackground)
    }
}
