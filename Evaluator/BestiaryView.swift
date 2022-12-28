//
//  BestiaryView.swift
//  Evaluator
//
//  Created by sarl_image_et on 24/12/2022.
//

import SwiftUI

struct BestiaryView: View {
    @EnvironmentObject var dataManager: DataManager
    @FetchRequest var beasts: FetchedResults<Beast>
    
    @State private var showingAddView = false
    
    let bestiary: Bestiary
    
    init (bestiary: Bestiary) {
        self.bestiary = bestiary
        _beasts = FetchRequest<Beast>(
            sortDescriptors: [SortDescriptor(\Beast.player)],
            predicate: NSPredicate(format: "bestiary == %@", bestiary)
        )
    }
    
    var body: some View {
        Section {
            ForEach(beasts) { beast in
                BeastElemView(beast: beast)
            }
        } header: {
            HStack {
                Text(bestiary.name!)
                Spacer()
                Button {
                    showingAddView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddBeastView(bestiary: bestiary)
        }
    }
}

/*
struct BestiaryView_Previews: PreviewProvider {
    static var previews: some View {
        BestiaryView(bestiary: bestiary)
    }
}
*/
