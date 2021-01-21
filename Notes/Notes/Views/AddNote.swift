//
//  AddNote.swift
//  Notes
//
//  Created by Егор on 18.01.2021.
//

import SwiftUI

struct AddNote: View {
    @State var title: String = ""
    @State var text: String = ""
    @Binding var isPresented: Bool
    
    let onComplete: (String, String) -> Void
    
    var body: some View {
        VStack(alignment: .trailing){
            VStack(alignment: .center){
                TextField("Enter title", text: $title)
                    .font(.title)
                TextField("Enter text", text: $text)
                    .font(.body)
                Button("Add"){
                    isPresented = false
                    onComplete(title, text)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 20)
        }
    }
}
