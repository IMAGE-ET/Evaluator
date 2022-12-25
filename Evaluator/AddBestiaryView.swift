//
//  AddBestiaryView.swift
//  Evaluator
//
//  Created by sarl_image_et on 24/12/2022.
//

import SwiftUI

struct AddBestiaryView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    
    @State private var bestiaryName = ""
    
    var body: some View {
            Form {
                Section() {
                    TextField("Bestiary Name :", text: $bestiaryName)
                    HStack {
                        Spacer()
                        Button("Validate") {
                            dataManager.addBestiary(bestiaryName: bestiaryName)
                            dismiss()
                        }
                        Spacer()
                    }
                }
        }
    }
}

struct AddBestiaryView_Previews: PreviewProvider {
    static var previews: some View {
        AddBestiaryView()
    }
}
