//
//  EditBeastView.swift
//  Evaluator
//
//  Created by sarl_image_et on 24/12/2022.
//

import SwiftUI

struct EditBeastView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    
    var beast: FetchedResults<Beast>.Element
    
    @State private var player = ""
    @State private var character = ""
    @State private var advices = ""
    
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
                        dataManager.editBeast(
                            beast: beast,
                            player: player,
                            chara: character,
                            advices: advices)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
