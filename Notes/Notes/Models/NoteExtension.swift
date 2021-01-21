//
//  NoteExtension.swift
//  Notes
//
//  Created by Егор on 19.01.2021.
//

import Foundation
import CoreData

extension Note{
    convenience init(context: NSManagedObjectContext ,title: String, text: String){
        self.init(context: context)
        self.title = title
        self.text = text
        self.isCompleted = false
    }
}
