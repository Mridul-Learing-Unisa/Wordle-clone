//
//  FlipView.swift
//  Wordle
//
//  Created by mri on 17/4/2025.
//

import SwiftUI

struct FlipView<Front, Back>: View where Front: View, Back: View {
    @Binding var isFlipped: Bool
    var front: () -> Front
    var back: () -> Back
    
    @State var flipped: Bool = false
    
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    
    init(isFlipped: Binding<Bool>, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self._isFlipped = isFlipped
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            if flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 1, y: 0, z: 0))
        .onChange(of: isFlipped) {
            flipFlashcard()
        }
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 1, y: 0, z: 0))
    }
    
    func flipFlashcard() {
        let animationTime = 0.5
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += -180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += -180
            flipped.toggle()
        }
    }
}
