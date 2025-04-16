//
//  LetterButtonView.swift
//  Wordle
//
//  Created by mri on 16/4/2025.
//

import SwiftUI

struct LetterButtonView: View {
    @EnvironmentObject var dm: WordleDataModel
    
    var letter: String
    
    var body: some View {
        Button{
            dm.addToCurrentWord(letter)
        }label: {
            Text(letter)
                .font(.system(size: 20))
                .frame(width: 35, height: 50)
                .background(dm.keyColors[letter])
                .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LetterButtonView(letter: "L").environmentObject(WordleDataModel())
}
