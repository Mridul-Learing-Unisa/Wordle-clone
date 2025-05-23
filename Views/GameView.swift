//
//  GameView.swift
//  Wordle
//
//  Created by mri on 14/4/2025.
//s

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dm: WordleDataModel
    @State private var showSettings = false
    @State private var showHelp = false
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Spacer()
                    VStack(spacing: 3){
                        ForEach(0...5, id: \.self){i in
                            GuessView(guess: $dm.guesses[i])
                                .modifier(Shake(animatableData: CGFloat(dm.incorrectAtempts[i])))
                        }
                    }
                    .frame(width: Global.boardWidth, height: 6 * Global.boardWidth/5, alignment: .center)
                    Spacer()
                    Keyboard()
                        .scaleEffect(Global.keyBoardScale)
                        .padding(2)
                    Spacer()
                }
                .disabled(dm.showStats)
                .navigationViewStyle(.stack)
                .navigationBarTitleDisplayMode(.inline)
                .overlay(alignment: .top){
                    if let toastText = dm.toastText {
                        ToastView(toastText: toastText)
                            .offset(y: 20)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        HStack{
                            if !dm.inPlay {
                                Button{
                                    dm.newGame()
                                } label: {
                                    Text("New")
                                        .foregroundColor(.primary)
                                }
                            }
                            Button{
                                showHelp.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
                        }
                    } 
                    ToolbarItem(placement:.principal) {
                        Text("WORDLE")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(dm.hardMode ? .red :.primary)
                            .minimumScaleFactor(0.5)
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        HStack{
                            Button{
                                withAnimation{
                                    dm.showStats.toggle()
                                }
                            } label: {
                                Image(systemName: "chart.bar.fill")
                            }
                            Button{
                                showSettings.toggle()
                            }label: {
                                Image(systemName: "gearshape")
                            }
                        }
                    }
                }
                .sheet(isPresented: $showSettings){
                    SettingsView()
                }
            }
            if dm.showStats {
                StatsView()
            }
            
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showHelp){
            HelpView()
            }
        }
    }

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(WordleDataModel())
    }
}
