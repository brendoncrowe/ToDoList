//
//  ToDoModel.swift
//  ToDoList
//
//  Created by Brendon Crowe on 2/28/23.
//

import UIKit

struct ToDo: Equatable & Codable {
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let fileURL = documentsDirectory.appending(path: "toDos").appendingPathExtension(".plist")
    
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadData() -> [ToDo]? {
        guard let savedToDos = try? Data(contentsOf: fileURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode([ToDo].self, from: savedToDos)
    }
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let savedToDos = try? propertyListEncoder.encode(toDos)
        try? savedToDos?.write(to: fileURL, options: .noFileProtection)
    }
    
    static func loadTestData() -> [ToDo] {
        let toDo1 = ToDo(title: "Workout", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "Study", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "Cook", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [toDo1, toDo2, toDo3]
    }
}
