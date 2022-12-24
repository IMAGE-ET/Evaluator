//
//  AddBeastView.swift
//  Evaluator
//
//  Created by sarl_image_et on 24/12/2022.
//

import SwiftUI

struct AddBeastView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    
    @State private var player = ""
    @State private var character = ""
    @State private var advices = ""
    
    let bestiary: Bestiary
    
    var body: some View {
            Form {
                Section() {
                    TextField("Player :", text: $player)
                    TextField("Character :", text: $character)
                    TextField("Advices :", text: $advices, axis: .vertical)
                        .lineLimit(5...)
                    HStack {
                        Spacer()
                        Button("Validate") {
                            dataManager.addBeast(
                                bestiary: bestiary,
                                player: player,
                                chara: character,
                                advices: advices)
                            print(bestiary)
                            dismiss()
                        }
                        Spacer()
                    }
                }
        }
    }
}
/*
struct AddBeastView_Previews: PreviewProvider {
    static var previews: some View {
        AddBeastView()
    }
}
*/
