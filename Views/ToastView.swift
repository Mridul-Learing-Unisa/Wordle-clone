//
//  ToastView.swift
//  Wordle
//
//  Created by mri on 18/4/2025.
//

import SwiftUI

struct ToastView: View {
    var toastText: String
    var body: some View {
        Text(toastText)
            .foregroundColor(.systemBackground)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary))
             
    }
}

#Preview {
    ToastView(toastText: "Not in word list")
}
