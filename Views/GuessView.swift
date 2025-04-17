//
//  GuessView.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//

import SwiftUI

struct GuessView: View {
    @Binding var guess: Guess
    var body: some View {
        HStack(spacing: 3){
            ForEach(0...4, id: \.self){ index in
                FlipView(isFlipped: $guess.cardFlipped[index]){
                    Text(guess.guessLetter[index]) .foregroundColor(.primary)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(Color.systemBackground)
                } back: {
                    Text(guess.guessLetter[index]) .foregroundColor(.primary)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(guess.bgColors[index])
                }
                
                    .font(.system(size: 35, weight: .heavy))
                    .border(Color(.secondaryLabel))
                    
                }
                
            }
        }
    }

#Preview {
    GuessView(guess: .constant(Guess(index: 0)))
}
