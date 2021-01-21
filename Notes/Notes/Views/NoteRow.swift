//
//  NoteView.swift
//  Notes
//
//  Created by Егор on 18.01.2021.
//

import SwiftUI

struct NoteRow: View {
    @ObservedObject var note: Note
    
    var body: some View {
        Toggle(isOn: $note.isCompleted){
            VStack{
                note.title.map(Text.init)
                    .font(.headline)
                note.text.map(Text.init)
                    .font(.subheadline)
            }
        }
        .padding()
        .toggleStyle(CheckboxToggleStyle())
    }
}

//struct NoteView_Previews: PreviewProvider {
//    @State var note = Note(title: "test", text: "test")
//    static var previews: some View {
//        NoteView(note: $note)
//    }
//}
