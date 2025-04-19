//
//  SettingsView.swift
//  Wordle
//
//  Created by mri on 19/4/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var csManager: ColorSchemeManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                Text("Change Theme")
                Picker("Display Mode", selection: $csManager.colorScheme){
                    Text("Light").tag(ColorScheme.light)
                    Text("Dark").tag(ColorScheme.dark)
                    Text("System").tag(ColorScheme.unspecified)
                }
                .pickerStyle(.segmented)
                Spacer()
            }.padding()
            .navigationTitle(Text("Options"))
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
    SettingsView()
        .environmentObject(ColorSchemeManager())
}
