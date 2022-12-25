//
//  BeastElemView.swift
//  Evaluator
//
//  Created by sarl_image_et on 25/12/2022.
//

import SwiftUI

struct BeastElemView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingEditView = false
    
    let beast: Beast
    
    var body: some View {
        NavigationLink {
            EvaluationView(beast: beast)
            //EditBeastView(beast: beast)
        } label: {
            Text(beast.player ?? "")
            Text("(\(beast.chara ?? ""))")
        }
        .swipeActions(edge: .trailing) { //Delete
            Button (role: .destructive) {
                deleteBeast()
            } label: {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        .swipeActions(edge: .leading) { // Edit
            Button {
                print("Editing beast \(beast.chara!)")
                showingEditView.toggle()
            } label: {
                Image(systemName: "pencil")
            }
            .tint(.blue)
        }
        .sheet(isPresented: $showingEditView) {
            EditBeastView(beast: beast)
        }
    }
    
    //Used for this record.
    func deleteBeast() {
        dataManager.delete(beast)
    }
}

/*
struct BeastElemView_Previews: PreviewProvider {
    static var previews: some View {
        BeastElemView(beast: beast)
    }
}
*/
