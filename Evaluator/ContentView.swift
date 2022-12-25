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
    
    @State private var showingAddBestiaryView = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Bestiaires")
                    .font(.title)
                Spacer()
                Button {
                    showingAddBestiaryView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }
            }
            .padding()
            .sheet(isPresented: $showingAddBestiaryView) {
                AddBestiaryView()
            }
            List {
                ForEach(bestiaries) {
                    bestiary in
                    BestiaryView(bestiary: bestiary)
                }
            }
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

