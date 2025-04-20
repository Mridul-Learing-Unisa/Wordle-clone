//
//  HelpView.swift
//  Wordle
//
//  Created by mri on 20/4/2025.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("""
                     Guess The **WORDLE** in 6. tries
                     
                     Each guess must be a valid 5 letter word. Hit enter button to submit
                     
                     After each guess, the color of the tiles will change to show how close your guess was to the word.
                     
                     """)
                Divider()
                Text("**Examples**")
                Image("Weary")
                    .resizable()
                    .scaledToFit()
                Text("The Letter **W** is in the word and in the correct spot")
                Image("Pills")
                    .resizable()
                    .scaledToFit()
                Text("The Letter **I** is in the word but in the wrong spot")
                Image("Vague")
                    .resizable()
                    .scaledToFit()
                Text("The Letter **U** is not in the word in any spot")
                Divider()
                Text("***Tap the NEW button for a new WORDLE***")
                Spacer()
                
            }
            .frame(width: min(Global.screenWidth-40,350))
            .navigationTitle(Text("How To Play"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        dismiss()
                    }label:{
                        Text("**X**")
                    }
                }
            }
        }
        
    }
}

#Preview {
    HelpView()
}
