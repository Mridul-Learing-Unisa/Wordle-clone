//
//  GameView.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//s

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dm: WordleDataModel
    var body: some View {
        NavigationView{
            VStack{
            Spacer()
            VStack(spacing: 3){
                GuessView(guess: $dm.guesses[0])
                GuessView(guess: $dm.guesses[1])
                GuessView(guess: $dm.guesses[2])
                GuessView(guess: $dm.guesses[3])
                GuessView(guess: $dm.guesses[4])
                GuessView(guess: $dm.guesses[5])
            }
            .frame(width: Global.boardWidth, height: 6 * Global.boardWidth/5, alignment: .center)
                Spacer()
                Keyboard()
                    .scaleEffect(Global.keyBoardScale)
                    .padding(2)
                Spacer()
            }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            
                        } label: {
                            Image(systemName: "questionmark.circle")
                            }
                        }
                        ToolbarItem(placement:.principal) {
                            Text("WORDLE")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                        }
                    ToolbarItem(placement: .navigationBarTrailing){
                        HStack{
                            Button{
                                
                            } label: {
                                Image(systemName: "chart.bar.fill")
                            }
                            Button{
                                 
                            }label: {
                                Image(systemName: "gearshape")
                            }
                        }
                    }
                }
            }
        .navigationViewStyle(.stack)
        }
    }

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(WordleDataModel())
    }
}
