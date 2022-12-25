//
//  DataManager.swift
//  FirstCoreData
//
//  Created by sarl_image_et on 23/12/2022.
//

//import Foundation
import SwiftUI
import CoreData

class DataManager: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        // Instanciate some vintage stuff
        container = NSPersistentCloudKitContainer(name: "Main")
        if (inMemory) {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _description, error in
            if let error = error {
                fatalError("Loading store : \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Give us a sample data for SwiftUI preview
    static var preview: DataManager = {
        let dataManager = DataManager(inMemory: true)
        
        do {
            try dataManager.createSampleData()
        } catch {
            fatalError("Fatal error creating preview sample data : \(error.localizedDescription)")
        }
        
        return dataManager
    }()
    
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        let bestiary = Bestiary(context: viewContext)
        bestiary.id = UUID()
        bestiary.beasts = []
                    
        for _ in 1...10 {
            let beast = Beast(context: viewContext)
            beast.id = UUID()
            beast.player = ["Clément", "Mathis", "Pierre"].randomElement()!
            beast.bestiary = bestiary
            beast.chara = ["Hero", "Ganondorf", "Lucas", "Chrom"].randomElement()!
            beast.advices = "This is a tricky oppenent, but you can use a classic strategy against those.\tGit gud."
        }
        
        let bestiary2 = Bestiary(context: viewContext)
        bestiary2.name = "Vanitas' Logos"
        bestiary2.id = UUID()
        bestiary2.beasts = []
                    
        for _ in 1...10 {
            let beast = Beast(context: viewContext)
            beast.id = UUID()
            beast.player = ["Jeanne", "Solomon"].randomElement()!
            beast.bestiary = bestiary2
            beast.chara = ["Demon 1", "Angel 1", "Demon 2", "Angel 2"].randomElement()!
            beast.advices = "This is interresting, I would like to do more research.\tLet me split your head in two so I can check your brain."
        }
        
        try viewContext.save()
    }
    
    func defaultBestiary() throws {
        let viewContext = container.viewContext
        
        let bestiary = Bestiary(context: viewContext)
        bestiary.id = UUID()
        bestiary.beasts = []
        
        try viewContext.save()
    }
    
    func addBestiary(bestiaryName: String) {
        let viewContext = container.viewContext
        
        let bestiary = Bestiary(context: viewContext)
        bestiary.id = UUID()
        bestiary.name = bestiaryName
        bestiary.beasts = []
        
        save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func addBeast(bestiary: Bestiary, player: String, chara: String, advices:String) {
        let viewContext = container.viewContext
        
        let beast = Beast(context: viewContext)
        beast.id = UUID()
        beast.bestiary = bestiary
        beast.player = player
        beast.chara = chara
        beast.advices = advices
        
        save()
    }
    
    func editBeast(beast: Beast, player: String, chara: String, advices:String) {
        beast.player = player
        beast.chara = chara
        beast.advices = advices
        
        save()
    }
    
    func delete(_ object: NSManagedObject) {
        print("Deleting object \(object)")
        container.viewContext.delete(object)
        
        save()
    }
    
    // Damn did I need to shit it, this one.
    func deleteAll() {
        let request = Bestiary.fetchRequest()
        let bestiaries = try! container.viewContext.fetch(request)
        
        for bestiary in bestiaries {
            delete(bestiary)
        }
    }
}

