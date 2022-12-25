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
    @State private var showingEditView = false
    @State private var focusedBeast: Beast?
    
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
                NavigationLink {
                    EvaluationView(beast: beast)
                    //EditBeastView(beast: beast)
                } label: {
                    Text(beast.player ?? "")
                    Text("(\(beast.chara ?? ""))")
                }
                /*
                .swipeActions(edge: .leading) {
                    Button {
                        focusedBeast = beast
                        print(focusedBeast!)
                        showingEditView.toggle()
                    } label: {
                        Text("Edit")
                    }
                    .tint(.blue)
                }
                 */
            }
            .onDelete(perform: deleteBeast)
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
        /*
        .sheet(isPresented: $showingEditView) {
            EditBeastView(beast: focusedBeast!)
        }
        */
    }
    
    // Deletes beast at the current offset
    private func deleteBeast(offsets: IndexSet) {
        print(offsets)
        withAnimation {
            offsets.map {
                beasts[$0]
            }
            .forEach(dataManager.delete)
            
            // Saves to our database
            dataManager.save()
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
