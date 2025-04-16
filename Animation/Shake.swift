//
//  Shake.swift
//  Wordle
//
//  Created by mri on 16/4/2025.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 19
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
        amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
        y: 0))
                                              
    }
    
}

