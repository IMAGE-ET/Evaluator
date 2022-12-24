//
//  ContentView.swift
//  Evaluator
//
//  Created by sarl_image_et on 23/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    @FetchRequest(sortDescriptors: [SortDescriptor(\Bestiary.name)]) var bestiaries: FetchedResults<Bestiary>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(bestiaries) {
                    bestiary in
                    BestiaryView(bestiary: bestiary)
                }
            }
            .navigationTitle("Bestiaires")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataManager = DataManager.preview
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataManager.container.viewContext)
            .environmentObject(dataManager)
    }
}

