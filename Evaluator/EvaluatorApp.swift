//
//  EvaluatorApp.swift
//  Evaluator
//
//  Created by sarl_image_et on 23/12/2022.
//

import SwiftUI


@main
struct EvaluatorApp: App {
    @StateObject var dataManager: DataManager
    
    init() {
        let dataManager = DataManager()
        _dataManager = StateObject(wrappedValue: dataManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
                .environmentObject(dataManager)
        }
    }
}
