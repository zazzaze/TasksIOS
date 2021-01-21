//
//  NotesApp.swift
//  Notes
//
//  Created by Егор on 18.01.2021.
//

import SwiftUI
import CoreData

@main
struct NotesApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
        .onChange(of: scenePhase){ phase in
            switch phase {
                case .active:
                    print("active")
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
                    saveContext()
            }
        }
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores(completionHandler: { (storeDescreption, error) in
            if let error = error{
                fatalError("Unresolved error")
            }
        })
        return container
    }()
    
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            } catch {
                
            }
        }
    }
}
