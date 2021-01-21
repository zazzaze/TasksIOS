//
//  ContentView.swift
//  Notes
//
//  Created by Егор on 18.01.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Note.title, ascending: true)]) var notes: FetchedResults<Note>
    
    @State var isPresented = false
    
    var note: Note?
    
    var body: some View {
        let completedNotes = { () -> [Note] in
            var newArr = [Note]()
            for i in notes{
                if i.isCompleted{
                    newArr.append(i)
                }
            }
            return newArr
        }()
        let uncompletedNotes = { () -> [Note] in
            var newArr = [Note]()
            for i in notes{
                if !i.isCompleted{
                    newArr.append(i)
                }
            }
            return newArr
        }()

        return NavigationView{
                //Button("Delete all", action: deleteAll)
            List{
                Section{
                    ForEach(uncompletedNotes, id: \.title){ note in
                        NoteRow(note: note)
                    }
                    .onDelete(perform: { indexSet in
                        deleteNote(arr: uncompletedNotes, at: indexSet)
                    })
                }
                Section(header: Text("Completed")){
                    ForEach(completedNotes, id: \.title){ note in
                        NoteRow(note: note)
                    }
                    .onDelete(perform: {indexSet in
                        deleteNote(arr: completedNotes, at: indexSet)
                    })
                }
            }.listStyle(GroupedListStyle())
            .sheet(isPresented: $isPresented){
                AddNote(isPresented: $isPresented){ title, text in
                    if(title.isEmpty && text.isEmpty){
                        return
                    }
                    let note = Note(context: managedObjectContext)
                    note.title = title
                    note.text = text
                    note.isCompleted = false
                    saveData()
                    self.isPresented = false
                }
            }
            .onAppear{
                withAnimation(.easeOut){
                    
                }
            }
            .navigationTitle("Notes")
            .navigationBarItems(
                trailing:
                    Button(action: { self.isPresented.toggle()}){
                    Image(systemName: "plus")
            })
        }
    }
    
    func deleteAll(){
        for i in notes{
            managedObjectContext.delete(i)
        }
        saveData()
    }
    
    func deleteNote(arr: [Note], at indexSet: IndexSet ){
        indexSet.forEach{ ind in
            let note = arr[ind]
            managedObjectContext.delete(note)
        }
    }

    
    func saveData(){
        do{
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
